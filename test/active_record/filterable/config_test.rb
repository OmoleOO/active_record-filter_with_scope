# frozen_string_literal: true

require "test_helper"

module ActiveRecord
  module Filterable
    class ConfigTest < Minitest::Test
      def setup
        super
        @filter_keys = %i[title description location]
      end

      def test_should_map_filter_keys_to_model_scope
        mapper = Job.filter_with filter_keys: @filter_keys, scope_prefix: "with_" do |scope_for|
          scope_for.title = :with_similar_title
        end

        assert_includes mapper.mapping.values, :with_similar_title
        assert(mapper.mapping.except(:title).values.all? { |scope| scope.to_s.start_with?("with_") })
      end

      def test_should_map_filter_keys_to_model_scope_when_prefix_is_not_set
        mapper = Job.filter_with filter_keys: @filter_keys do |scope_for|
          scope_for.title = :with_similar_title
        end

        (@filter_keys - [:title]).each { |filter_key| assert_includes mapper.mapping.values, filter_key }

        assert_includes mapper.mapping.values, :with_similar_title
      end
    end
  end
end
