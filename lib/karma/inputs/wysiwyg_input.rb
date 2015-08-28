require 'simple_form'

module Karma
  module Inputs
    class WysiwygInput < ::SimpleForm::Inputs::Base
      def input(wrapper_options)
        hidden_field + editor + upload_indicator
      end

      private

      def hidden_field
        @builder.hidden_field attribute_name
      end

      def editor
        template.content_tag :div, class: 'wysiwyg-editor', data: { upload_url: template.try(:attachments_url), target: "##{input_dom_id}"} do
          template.raw object.send(attribute_name)
        end
      end

      def upload_indicator
        template.content_tag :p, class: 'text-muted image-upload-indicator hidden' do
          template.content_tag :small do
            content_tag(:i, '', class: 'fa fa-fw fa-spinner fa-spin') + ' Uploading image ...'
          end
        end
      end

      def input_dom_id
        ActionView::Helpers::Tags::TextArea.new(object_name, attribute_name, object).send(:add_default_name_and_id, input_options)
      end
    end
  end
end
