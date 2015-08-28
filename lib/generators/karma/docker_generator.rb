require 'rails/generators'

module Karma
  class DockerGenerator < ::Rails::Generators::Base
    desc 'Copy Docker settings'
    source_root ::File.expand_path('../templates', __FILE__)

    def asking
      @project = ask('What is the name of the docker project?').downcase.underscore
      @maintainer = ask('What is the maintainer email address?')
    end

    def copy_dockerfile
      template 'docker/Dockerfile', 'Dockerfile'
    end

    def copy_docker_scripts
      template 'docker/scripts/build',   'docker/scripts/build'
      template 'docker/scripts/migrate', 'docker/scripts/migrate'
      template 'docker/scripts/run',     'docker/scripts/run'
      template 'docker/scripts/console', 'docker/scripts/console'
    end

    def copy_docker_configs
      template 'docker/config/nginx.conf',     'docker/nginx.conf'
      template 'docker/config/nginx-env.conf', 'docker/nginx-env.conf'
      template 'docker/config/database.yml',   'docker/database.yml'
      template 'docker/config/redis.yml',      'docker/redis.yml'
    end

    def copy_docker_inits
      template 'docker/init/01_permissions', 'docker/init/01_permissions'
      template 'docker/init/02_assets',      'docker/init/02_assets'
      template 'docker/init/03_sidekiq',     'docker/init/03_sidekiq'
    end

    def freeze_gemfiles
      run 'mkdir -p docker/freeze'
      run 'cp Gemfile docker/freeze/'
      run 'cp Gemfile.lock docker/freeze/'
    end
  end
end
