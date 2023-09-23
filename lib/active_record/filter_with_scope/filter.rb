# frozen_string_literal: true

module ActiveRecord
  module FilterWithScope
    # filter active record
    module Filter
      mattr_accessor :filter_params, :initial_records

      def filter(filter_params, initial_records: where(nil))
        self.filter_params   = filter_params
        self.initial_records = initial_records

        validate_model_scopes_defined!
        call_model_scopes_on_filter_params
      end

      private

      def call_model_scopes_on_filter_params
        return none if filter_params.blank?

        records = initial_records
        clean_filter_params.each do |filter_key, value|
          records = records.public_send(filter_keys_model_scope_mapping[filter_key], value)
        end
        records
      end

      def clean_filter_params
        @clean_filter_params ||= filter_params.slice(*filter_keys_model_scope_mapping.keys)
      end

      def filter_keys_model_scope_mapping
        @filter_keys_model_scope_mapping ||= ActiveRecord::FilterWithScope::Config.filterable_model_scope_mapping
      end

      def validate_model_scopes_defined!
        clean_filter_params.each do |filter_key, _value|
          klass = self
          model_scope = filter_keys_model_scope_mapping[filter_key]
          next if klass.respond_to?(model_scope)

          raise ActiveRecord::FilterWithScope::UndefinedModelScopeError,
                "The #{klass.name} model does not implement #{model_scope}"
        end
      end

      private :filter_params=
    end
  end
end
