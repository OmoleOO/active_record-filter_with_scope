# frozen_string_literal: true

require_relative "filter_with_scope/version"

module ActiveRecord
  # Enable filter for active_record subclasses
  module FilterWithScope
    class Error < StandardError; end
    class ArgumentError < Error; end
    class UndefinedModelScopeError < Error; end

    class << self
      def extended(klass)
        return if klass.respond_to?(:descends_from_active_record?) && klass.descends_from_active_record?

        raise ArgumentError, "#{klass} is not filterable, only ActiveRecord subclasses are!"
      end
    end
  end
end

require_relative "filter_with_scope/railtie" if defined?(Rails::Railtie)
