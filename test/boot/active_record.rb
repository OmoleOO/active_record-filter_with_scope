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
end

class PlainRubyClass
  def test; end
end
