# frozen_string_literal: true

module ActiveRecord
  module FilterWithScope
    # Setup filter_with_scope/config inside active_record
    class Railtie < Rails::Railtie
      initializer "filter_with_scope.setup" do
        ActiveSupport.on_load :active_record do
          require "active_record/filter_with_scope/config"
          require "active_record/filter_with_scope/filter"
          extend ActiveRecord::FilterWithScope::Config
          extend ActiveRecord::FilterWithScope::Filter
        end
      end
    end
  end
end
