module Karma
  module Helpers
    module WhatIfHelper
      def active_if(predicates)
        result_of(predicates) ? 'active' : ''
      end

      def disabled_if(predicates)
        result_of(predicates) ? 'disabled' : ''
      end

      def yes_if(predicates)
        result_of(predicates) ? 'Yes' : 'No'
      end

      private

      def result_of(predicates)
        if predicates.is_a?(Hash)
          predicates.all? do |k, v|
            send(:"match_#{k}?", v)
          end
        else
          predicates
        end
      end
    end
  end
end
