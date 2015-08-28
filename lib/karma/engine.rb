require 'karma/helpers'

module Karma
  class Engine < ::Rails::Engine
    initializer 'karma.assets.precompile' do |app|
      %w(stylesheets javascripts karma-libs).each do |sub|
        app.config.assets.paths << root.join('assets', sub).to_s
      end
    end

    initializer 'karma.helpers' do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, Karma::Helpers::MatchingHelper
        ActionView::Base.send :include, Karma::Helpers::WhatIfHelper
        ActionView::Base.send :include, Karma::Helpers::UsefulHelper
      end
    end

    initializer 'karma.inputs' do |app|
      if Object.const_defined?('SimpleForm')
        require 'karma/inputs'
      end
    end
  end
end
