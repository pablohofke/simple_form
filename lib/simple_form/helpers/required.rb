module SimpleForm
  module Helpers
    module Required
      # Whether this input is valid for HTML 5 required attribute.
      def has_required?
        attribute_required? && SimpleForm.html5 && SimpleForm.browser_validations
      end

      private

      def attribute_required?
        @required
      end
      
      # required_by_default has to take precedence over the validations
      def calculate_required
        if !attribute_required_by_default?
          attribute_required_by_default?
        elsif !options[:required].nil?
          options[:required]
        else has_validators?
            (attribute_validators + reflection_validators).any? do |v|
              v.kind == :presence && valid_validator?(v)
            end
        end
      end

      def attribute_required_by_default?
        SimpleForm.required_by_default
      end

      def required_class
        attribute_required? ? :required : :optional
      end
    end
  end
end