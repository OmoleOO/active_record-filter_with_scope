# frozen_string_literal: true

require_relative "filterable/version"

module ActiveRecord
  module Filterable
    class Error < StandardError; end
  end
end

require_relative "filterable/railtie" if defined?(Rails::Railtie)
