# Compatibility fixes for Ruby 3+
unless defined?(Fixnum); Fixnum = Integer; end
unless defined?(Bignum); Bignum = Integer; end

if RUBY_VERSION >= "3.0"
  class << File
    alias_method :exists?, :exist? unless respond_to?(:exists?)
  end
end

require "uri"
unless URI.respond_to?(:escape)
  module URI
    def self.escape(str) = URI::DEFAULT_PARSER.escape(str)
    def self.unescape(str) = URI::DEFAULT_PARSER.unescape(str)
  end
end
