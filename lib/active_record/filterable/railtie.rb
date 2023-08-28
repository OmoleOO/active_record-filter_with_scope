# frozen_string_literal: true

module ActiveRecord
  module Filterable
    # Setup filterable/config inside active_record
    class Railtie < Rails::Railtie
      initializer "filterable.setup" do
        ActiveSupport.on_load :active_record do
          require "active_record/filterable/config"
          extend ActiveRecord::Filterable::Config
        end
      end
    end
  end
end
