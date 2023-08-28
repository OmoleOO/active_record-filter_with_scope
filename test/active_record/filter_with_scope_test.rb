# frozen_string_literal: true

require "test_helper"

module ActiveRecord
  class FilterWithScopeTest < Minitest::Test
    def test_should_raise_an_error_if_extended_by_non_active_record_class
      error = assert_raises(ActiveRecord::FilterWithScope::ArgumentError) do
        PlainRubyClass.extend ActiveRecord::FilterWithScope
      end

      assert_equal "PlainRubyClass is not filterable, only ActiveRecord subclasses are!", error.message
    end

    def test_can_be_extended_by_active_record_subclass
      test_active_record_subclass = Class.new(ApplicationRecord)
      assert_silent { test_active_record_subclass.extend ActiveRecord::FilterWithScope }
    end
  end
end
