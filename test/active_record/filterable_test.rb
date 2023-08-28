# frozen_string_literal: true

require "test_helper"

module ActiveRecord
  class FilterableTest < Minitest::Test
    def test_should_raise_an_error_if_extended_by_non_active_record_class
      error = assert_raises(ActiveRecord::Filterable::ArgumentError) do
        PlainRubyClass.extend ActiveRecord::Filterable
      end

      assert_equal "PlainRubyClass is not filterable, only ActiveRecord subclasses are!", error.message
    end
  end
end
