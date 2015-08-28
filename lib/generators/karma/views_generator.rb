require 'rails/generators'

module Karma
  class ViewsGenerator < ::Rails::Generators::Base
    desc 'Copy Karma Scaffold template files'
    source_root ::File.expand_path('../templates', __FILE__)

    def copy_views
      copy_file 'views/index.html.slim', 'lib/templates/slim/scaffold/index.html.slim'
      copy_file 'views/new.html.slim',   'lib/templates/slim/scaffold/new.html.slim'
      copy_file 'views/edit.html.slim',  'lib/templates/slim/scaffold/edit.html.slim'
      copy_file 'views/_form.html.slim', 'lib/templates/slim/scaffold/_form.html.slim'
    end
  end
end
