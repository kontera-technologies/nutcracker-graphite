require_relative '../minitest_helper'

module Nutcracker
  module Graphite
    class AgentTester < Test

      def setup
        @nutcracker = mock
        @options = {:graphite => 'shuki'}
        @agent = Agent.new( @nutcracker, @options )
      end

      attr_reader :agent, :options, :nutcracker

      def test_stats_parser
        assert_equal load_fixture('expected_stats.ruby_hash'),
          agent.send(:parse,load_fixture('stats.json'))
      end

      def test_metrics_generator_wo_redis_info
        nutcracker.expects(:config).returns({'page_data_cluster' => {'redis' => true}})
        agent.expects(:redis_info).with('node1:6379').returns({})

        assert_equal load_fixture('expected_metrics_wo_redis_info.ruby_hash') ,
          agent.send(:metrics,load_fixture('expected_stats.ruby_hash'))

      end

      def test_metrics_generator_with_redis_info
        nutcracker.expects(:config).returns({'page_data_cluster' => {'redis' => true}})
        agent.expects(:redis_info).with('node1:6379').returns({'blabla' => 20})

        expected = load_fixture('expected_metrics_wo_redis_info.ruby_hash').merge(
          "nutcracker.page_data_cluster.Eran-Levis-MacBook-Pro_local.node1_6379.blabla"=>20
        )

        assert_equal expected, agent.send(:metrics,load_fixture('expected_stats.ruby_hash'))
      end

      def test_metrics_generator_on_non_redis_cluster
        nutcracker.expects(:config).returns({})
        agent.expects(:redis_info).never
        assert_equal load_fixture('expected_metrics_wo_redis_info.ruby_hash'),
          agent.send(:metrics,load_fixture('expected_stats.ruby_hash'))
      end

      def test_redis_info
        data = load_fixture 'redis_info.json'
        redis = mock
        Redis.expects(:connect).with(url: 'redis://node1:6379').returns(redis)
        redis.expects(:info).returns(data['info'])
        redis.expects(:dbsize).returns(data['dbsize'])
        redis.expects(:config).with(:get,'maxmemory').returns(data['memory'])
        redis.expects(:quit)
        assert_equal load_fixture('expected_redis_info.json'),
          agent.send(:redis_info,'node1:6379')
      end

    end
  end
end
