require 'rails/generators'

module Karma
  class InstallGenerator < ::Rails::Generators::NamedBase
    desc 'Install Karma Theme'
    source_root ::File.expand_path('../templates', __FILE__)

    def copy_application_layout
      remove_file 'app/views/layouts/application.html.erb'
      template 'layouts/application.html.slim', 'app/views/layouts/application.html.slim'
    end

    def copy_devise_layout
      template 'layouts/devise.html.slim', 'app/views/layouts/devise.html.slim'
    end

    def copy_layout_you
      copy_file 'layouts/you.html.slim', 'app/views/layouts/shared/_you.html.slim'
    end

    def keep_components_and_pages
      add_file 'app/assets/javascripts/components/.gitkeep'
      add_file 'app/assets/javascripts/pages/.gitkeep'
      add_file 'app/assets/stylesheets/components/.gitkeep'
      add_file 'app/assets/stylesheets/pages/.gitkeep'
    end

    def copy_application_js
      remove_file 'app/assets/javascripts/application.js'
      copy_file 'assets/application.js.coffee', 'app/assets/javascripts/application.js.coffee'
    end

    def copy_application_css
      remove_file 'app/assets/stylesheets/application.css'
      copy_file 'assets/application.css.sass', 'app/assets/stylesheets/application.css.sass'
    end

    def copy_devise_views
      copy_file 'devise/sessions/new.html.slim', 'app/views/devise/sessions/new.html.slim'
    end
  end
end
