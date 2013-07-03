require 'nutcracker'
require 'nutcracker/graphite/version'
require 'graphite-api'

module Nutcracker
  module Graphite

    def self.start nutcracker, options
      Agent.new(nutcracker, options).start
    end

    class Agent
      INTERVAL=60

      attr_reader :nutcracker, :graphite

      def initialize nutcracker, options
        @nutcracker = nutcracker
        @graphite = GraphiteAPI.new options.merge interval: INTERVAL
      end

      def start
        @task ||= graphite.every(INTERVAL) do |client|
          begin
            client.metrics metrics nutcracker.overview
          rescue Exception => e
            STDERR.puts [e.message,e.backtrace.join("\n")]
          end
        end
        self
      end

      def stop
        @task and @task.cancel
      end

      private

      def metrics stats
        data = stats.clone
        escape = ->(s) { s.gsub(/redis:\/\//,'').gsub(/\.|\:/,'_') }
        hash = {}
        data[:clusters].each do |cluster_data|
          cluster_key = ['nutcracker',cluster_data[:name],data['source']].map(&escape).join('.')
          cluster_data.each do |key, value|
            hash[[cluster_key,key].join('.')] = value if value.is_a? Fixnum or value.is_a? Float
          end

          cluster_data[:nodes].each do |node_data|
            info = node_data.delete(:info)
            node_key = "#{cluster_key}.#{escape.(node_data[:server_url])}"
            node_data.each do |key, value|
              hash["#{node_key}.cluster_#{key}"] = value if value.is_a? Fixnum or value.is_a? Float
            end
            info.each {|k,v| hash["#{node_key}.#{k}"] = v }
          end

        end
        hash
      end

    end
  end
end
