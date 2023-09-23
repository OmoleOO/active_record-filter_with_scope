# frozen_string_literal: true

require "test_helper"

module ActiveRecord
  module FilterWithScope
    class ConfigTest < Minitest::Test
      def setup
        super
        @filter_keys = %i[title description location]
      end

      def filterable_model_scope_mapping
        ActiveRecord::FilterWithScope::Config.filterable_model_scope_mapping
      end

      def test_should_map_filter_keys_to_model_scope
        Job.filter_with filter_keys: @filter_keys, scope_prefix: "with_" do |scope_for|
          scope_for.title = :similar_title
        end

        mapping = filterable_model_scope_mapping

        assert_includes mapping.values, :similar_title
        assert(mapping.except(:title).values.all? { |scope| scope.to_s.start_with?("with_") })
      end

      def test_should_map_filter_keys_to_model_scope_when_prefix_is_not_set
        Job.filter_with filter_keys: @filter_keys do |scope_for|
          scope_for.title = :with_similar_title
        end

        mapping = filterable_model_scope_mapping

        (@filter_keys - [:title]).each { |filter_key| assert_includes mapping.values, filter_key }

        assert_includes mapping.values, :with_similar_title
      end
    end
  end
end
