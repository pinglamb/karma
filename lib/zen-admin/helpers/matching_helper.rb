module ZenAdmin
  module Helpers
    module MatchingHelper
      def namespace_name
        controller_path.scan(/(.*)\//).flatten.first
      end

      def match_namespace?(*args)
        if args.first.nil? && namespace_name.nil?
          true
        else
          namespace_name.in?(Array.wrap(args).flatten.collect(&:to_s))
        end
      end

      def match_controller?(*args)
        controller_name.in?(Array.wrap(args).flatten.collect(&:to_s))
      end

      def match_action?(*args)
        action_name.in?(Array.wrap(args).flatten.collect(&:to_s))
      end

      def match_id?(*args)
        params[:id].to_s.in?(Array.wrap(args).flatten.collect(&:to_s))
      end

      def match_params?(q)
        q.all? do |key, values|
          Array.wrap(values).any? do |value|
            params[k] == value
          end
        end
      end

      def match_route?(*args)
        args.flatten! if args.is_a?(Array)
        Array.wrap(args).any? do |combination|
          if m = combination.match(/^((?<namespace>.*)\/)?(?<controller>.*)\#(?<action>.*)$/)
            (m[:namespace].blank? || match_namespace?(m[:namespace])) &&
              match_controller?(m[:controller]) &&
              match_action?(m[:action])
          end
        end
      end
    end
  end
end
