run "rbenv local #{`rbenv global`}"

inject_into_file 'Gemfile', %Q{\ngem 'karma', github: 'pinglamb/karma'}, after: /gem 'therubyracer'.*/
assets_lib = %w(bourbon bootstrap-sass font-awesome-rails bower-rails).collect {|lib| %Q{\ngem '#{lib}'}}.join
inject_into_file 'Gemfile', assets_lib, after: /gem 'therubyracer'.*/
inject_into_file 'Gemfile', %Q{\n# Other Assets}, after: /gem 'therubyracer'.*/

common_lib = %w(slim-rails simple_form default_value_for ranked-model figaro devise rolify enumerize active_model_serializers kaminari gravatarify).collect {|lib| %Q{\ngem '#{lib}'}}.join
inject_into_file 'Gemfile', common_lib, after: "gem 'jquery-rails'"

inject_into_file 'Gemfile', %Q{\ngem 'actionform', github: 'pinglamb/actionform', branch: 'allow-using-block-for-link-helpers', require: 'action_form'}, after: "gem 'simple_form'"

inject_into_file 'Gemfile', %Q{\ngem 'nprogress-rails'}, after: /gem 'turbolinks'.*/

gsub_file 'Gemfile', "gem 'jbuilder'", "# gem 'jbuilder'"

dev_lib = %w(quiet_assets better_errors binding_of_caller rb-fsevent).collect {|lib| %Q{\n  gem '#{lib}'}}.join
inject_into_file 'Gemfile', "\n#{dev_lib}", after: /gem 'spring'.*/
test_lib = %w(rspec-rails factory_girl_rails capybara database_cleaner simplecov email_spec rails-erd nyan-cat-formatter spring-commands-rspec timecop).collect {|lib| %Q{\n  gem '#{lib}'}}.join
inject_into_file 'Gemfile', test_lib, after: /gem 'spring'.*/

run 'bundle install'

generate 'simple_form:install --bootstrap'
run 'figaro install'
generate 'rspec:install'
generate 'bower_rails:initialize'

rake 'db:drop'
rake 'db:create'
generate 'devise:install'
generate 'devise user provider:string uid:string name:string'
devise_migration = Dir['db/migrate/*_devise_create_users.rb'].first
gsub_file devise_migration, '# t', 't'
gsub_file devise_migration, '# add_index', 'add_index'
inject_into_file devise_migration, "\n    add_index :users, [:provider, :uid]", after: "add_index :users, :authentication_token, unique: true"
rake 'db:migrate'
generate 'rolify Role User'
rake 'db:migrate'

generate 'kaminari:views bootstrap3 -e slim'

application "config.generators do |g|\n      g.stylesheets false\n      g.javascripts false\n      g.helper false\n      g.view_specs false\n      g.helper_specs false\n    end\n"

run "cp config/database.yml config/database.yml.example"
inject_into_file ".gitignore", "\n/config/database.yml", :after => "/.bundle"
inject_into_file ".gitignore", "\n.DS_Store", :after => "/.bundle"
gsub_file '.rspec', '--color', '--color --format NyanCatFormatter'

generate "karma:install #{@app_name}"
generate "karma:views"
