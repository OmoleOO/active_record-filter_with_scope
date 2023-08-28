# frozen_string_literal: true

module ActiveRecord
  module Filterable
    # Setup filterable/config inside active_record
    class Railtie < Rails::Railtie
      initializer "filterable.setup" do
        ActiveSupport.on_load :active_record do
          require "active_record/filterable/config"
          require "active_record/filterable/filter"
          extend ActiveRecord::Filterable::Config
          extend ActiveRecord::Filterable::Filter
        end
      end
    end
  end
end
