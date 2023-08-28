# frozen_string_literal: true

require_relative "filterable/version"

module ActiveRecord
  # Enable filter for active_record subclasses
  module Filterable
    class Error < StandardError; end
    class ArgumentError < Error; end

    class << self
      def extended(klass)
        return if klass.respond_to?(:descends_from_active_record?) && klass.descends_from_active_record?

        raise ArgumentError, "#{klass} is not filterable, only ActiveRecord subclasses are!"
      end
    end
  end
end

require_relative "filterable/railtie" if defined?(Rails::Railtie)
