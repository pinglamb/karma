require 'rails/generators'

module ZenAdmin
  class InstallGenerator < ::Rails::Generators::Base
    desc 'Copy ZenAdmin Scaffold template files'
    source_root ::File.expand_path('../templates', __FILE__)

    def copy_views
      copy_file 'views/index.html.slim', 'lib/templates/slim/scaffold/index.html.slim'
      copy_file 'views/new.html.slim',   'lib/templates/slim/scaffold/new.html.slim'
      copy_file 'views/edit.html.slim',  'lib/templates/slim/scaffold/edit.html.slim'
      copy_file 'views/_form.html.slim', 'lib/templates/slim/scaffold/_form.html.slim'
    end

    def copy_devise_views
      copy_file 'devise/sessions/new.html.slim', 'app/views/devise/sessions/new.html.slim'
    end
  end
end
