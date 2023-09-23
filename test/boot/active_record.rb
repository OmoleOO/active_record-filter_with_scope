# frozen_string_literal: true

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new($stdout)

ActiveRecord::Schema.define do
  create_table :jobs, force: true do |t|
    t.string :title
    t.text :description
    t.string :location
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Job < ApplicationRecord
  def self.create_dynamic_scopes(scope_names)
    scope_names.each do |key|
      class_eval(
        # Class Job
        #   scope :title, ->(val) { where(:title => val) }
        # end
        <<-RUBY, __FILE__, __LINE__ + 1
          scope :#{key}, ->(val) { where(:#{key} => val) }
        RUBY
      )
    end
  end
end

class PlainRubyClass
  def test; end
end
