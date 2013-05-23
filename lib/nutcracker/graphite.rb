require 'nutcracker/graphite/version'
require 'graphite-api'
require 'redis'

module Nutcracker
  module Graphite

    def self.start nutcracker, options
      Agent.new(nutcracker, options).start
    end

    def self.version
      Nutcracker::VERSION
    end

    class Agent
      INTERVAL=60

      attr_reader :nutcracker, :graphite

      def initialize nutcracker, options
        @nutcracker = nutcracker
        @graphite = GraphiteAPI.new options.merge(:interval => INTERVAL)
      end

      def start
        @task ||= graphite.every INTERVAL do |client|
          client.metrics metrics parse nutcracker.stats
        end
      end

      def stop
        @task and @task.cancel
      end

      private

      def metrics parsed_stats
        data = parsed_stats.clone
        escape = ->(s) { s.gsub(/\.|\:/,'_') }
        hash = {}
        data[:clusters].each do |cluster, cluster_data|
          cluster_key = ['nutcracker',cluster,data['source']].map(&escape).join('.')
          cluster_data.each do |key, value|
            hash[[cluster_key,key].join('.')] = value if value.is_a? Fixnum or value.is_a? Float
          end

          cluster_data[:nodes].each do |node, node_data|
            node_key = "#{cluster_key}.#{escape.(node)}.cluster_"
            node_key2 = "nutcreacker.redis.#{node.split(":").join('_')}"
            node_data.each do |key, value|
              hash[[node_key,key].join] = value if value.is_a? Fixnum or value.is_a? Float
              addional_data(node).each {|k,v| hash[[node_key2,k].join('.')] = v }
            end
          end

        end
        hash
      end

      def addional_data url
        url = "redis://#{url}" unless url =~ /redis\:\/\//
        redis = Redis.connect url: url
        server_info = redis.info
        db_size     = redis.dbsize
        max_memory  = redis.config(:get, 'maxmemory')['maxmemory'].to_i
        redis.quit
        {
          'connections'     => server_info['connected_clients'].to_i,
          'used_memory'     => server_info['used_memory'].to_f,
          'used_memory_rss' => server_info['used_memory_rss'].to_f,
          'fragmentation'   => server_info['mem_fragmentation_ratio'].to_f,
          'expired_keys'    => server_info['expired_keys'].to_i,
          'evicted_keys'    => server_info['evicted_keys'].to_i,
          'hits'            => server_info['keyspace_hits'].to_i,
          'misses'          => server_info['keyspace_misses'].to_i,
          'keys'            => db_size,
          'max_memory'      => max_memory,
          'hit_ratio'       => 0
        }.tap {|d| d['hit_ratio'] = d['hits'].to_f / (d['hits']+d['misses']).to_f if d['hits'] > 0 }
      end


      def parse stats
        { :clusters => {} }.tap do |data|
          (stats.dup).each do |key, value|
            (data[key] = value and next) if !value.is_a? Hash
            data[:clusters][key] = value
            data[:clusters][key][:nodes] = {}
            data[:clusters][key].each do |key2,value2|
              if value2.kind_of? Hash and key2.is_a? String
                data[:clusters][key][:nodes][key2] = data[:clusters][key].delete(key2)
              end
            end
          end
        end
      end

    end
  end
end
