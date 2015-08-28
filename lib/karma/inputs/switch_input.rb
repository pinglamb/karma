require 'simple_form'

module Karma
  module Inputs
    class SwitchInput < ::SimpleForm::Inputs::BooleanInput
      def input(wrapper_options)
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        merged_input_options[:class] ||= []
        merged_input_options[:class].delete("form-control")

        template.content_tag :div do
          build_check_box(unchecked_value, merged_input_options)
        end
      end
    end
  end
end
