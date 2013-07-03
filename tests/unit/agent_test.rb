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
      
      def test_metrics_generator
        assert_equal(
          load_fixture('output.ruby_hash'),
          agent.send(:metrics,load_fixture('input.ruby_hash'))
        )
      end
      
    end
  end
end
