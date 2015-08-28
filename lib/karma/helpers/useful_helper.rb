module Karma
  module Helpers
    module UsefulHelper
      def bootstrap_flash
        render partial: 'karma/bootstrap_flash' if flash.present?
      end

      def image_tag_presence(image, options = {})
        if image.present?
          image_tag options[:url] || image, options
        else
          content_tag :img, nil, { data: { src: "holder.js/\#{options[:fallback]}/text::(" } }.merge(options)
        end
      end

      def number_to_currency_presence(number, options = {})
        if number.present?
          number_to_currency number, options
        else
          'N/A'
        end
      end

      def link_back_or_to(*args, &block)
        if params[:back_to].present?
          if block_given?
            args[0] = params[:back_to]
          else
            args[1] = params[:back_to]
          end
        end

        link_to(*args, &block)
      end
    end
  end
end
