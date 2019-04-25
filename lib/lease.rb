require 'lease/version'
require 'lease/config'
require 'lease/active_record'
require 'carrierwave'

module Lease

  class Error < StandardError; end

  def self.setup
    yield config
  end

  def self.config
    @config ||= Config.new
  end

end

require 'lease/engine' if defined?(Rails)
