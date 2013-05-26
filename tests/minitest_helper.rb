$:.unshift File.expand_path '../../lib', __FILE__
gem 'minitest'

require 'minitest/autorun'
require 'mocha/setup'
require 'nutcracker/graphite'
require 'tempfile'
require 'fileutils'
require 'json'

module Nutcracker
  module Graphite
    class Test < ::Minitest::Test
      def fixture name
        File.expand_path("../fixtures/#{name}", __FILE__)
      end

      def load_fixture name
        raw = File.read fixture name
        if name.end_with? '.json'
          JSON.parse raw
        elsif name.end_with? '.ruby_hash'
          eval raw
        else
          raw
        end
      end

    end
  end
end
