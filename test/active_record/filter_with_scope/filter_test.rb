# frozen_string_literal: true

require "test_helper"

module ActiveRecord
  module FilterWithScope
    class FilterTest < Minitest::Test
      def setup
        super
        @valid_params = { title: "Fancy (m/w/d)", description: "Fancy description", location: "Ibadan" }
      end

      def job_class
        Class.new(Job)
      end

      def test_active_record_subclass_can_be_filtered
        klazz = job_class
        klazz.filter_with filter_keys: []

        filtered_records = klazz.filter({})

        assert_equal klazz.none, filtered_records
      end

      def test_error_is_raised_when_model_scope_is_undefined
        klazz = job_class
        klazz.filter_with filter_keys: @valid_params.keys

        assert_raises(ActiveRecord::FilterWithScope::UndefinedModelScopeError) { klazz.filter(@valid_params) }
      end

      def test_active_record_subclass_can_be_filtered_with_valid_params
        job = job_class.create!(@valid_params)

        klazz = job.class
        klazz.create_dynamic_scopes(@valid_params.keys)

        klazz.filter_with filter_keys: @valid_params.keys

        filtered_records = klazz.filter(@valid_params)

        assert_equal 1, filtered_records.size
      end
    end
  end
end
