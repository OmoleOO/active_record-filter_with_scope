# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("./lib", __dir__))

require "rails/railtie"
require "active_record"
require "active_record/filter_with_scope"

require "minitest/autorun"

require "logger"
require "debug"

ActiveRecord::FilterWithScope::Railtie.run_initializers

require_relative "boot/active_record"

Job.create!(title: "New Job", description: "Fancy", location: "Lagos")
