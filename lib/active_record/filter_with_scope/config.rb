# frozen_string_literal: true

module ActiveRecord
  module FilterWithScope
    # Configuration module
    module Config
      mattr_accessor :filterable_model_scope_mapping
      private :filterable_model_scope_mapping=

      def filter_with(filter_keys: [], scope_prefix: nil, &block)
        mapper = Mapper.new(filter_keys, scope_prefix)
        block.call(mapper) if block_given?
        Config.filterable_model_scope_mapping = mapper.mapping
      end

      # Mapper class
      class Mapper
        def initialize(filter_keys, scope_prefix)
          @filter_keys = filter_keys
          @scope_prefix = scope_prefix
          @filter_keys_model_scope_mapping ||= {}
          create_attr_accessor_for_filter_keys do |filter_key|
            [
              "def #{filter_key}; @filter_keys_model_scope_mapping[:#{filter_key}]; end",
              "def #{filter_key}=(scope); @filter_keys_model_scope_mapping[:#{filter_key}] = scope; end"
            ]
          end
        end

        def mapping
          map!
          filter_keys_model_scope_mapping
        end

        private

        attr_reader :filter_keys, :scope_prefix, :filter_keys_model_scope_mapping

        def map!
          filter_keys.each do |filter_key|
            filter_keys_model_scope_mapping[filter_key.to_sym] = public_send(filter_key) || [
              scope_prefix.to_s, filter_key.to_s
            ].join.to_sym
          end
        end

        def create_attr_accessor_for_filter_keys(&block)
          location = caller_locations(1, 1).first
          attr_writers = filter_keys.flat_map(&block)
          Mapper.class_eval attr_writers.join("\n\n"), location.path, location.lineno
        end
      end
    end
  end
end
