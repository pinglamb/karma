run "rbenv local #{`rbenv global`}"

inject_into_file 'Gemfile', %Q{\ngem 'zen-admin', github: 'pinglamb/zen-admin'}, after: /gem 'therubyracer'.*/
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

generate 'zen_admin:install'

generate 'kaminari:views bootstrap3 -e slim'

application "config.generators do |g|\n      g.stylesheets false\n      g.javascripts false\n      g.helper false\n      g.view_specs false\n      g.helper_specs false\n    end\n"

remove_file 'app/views/layouts/application.html.erb'
create_file 'app/views/layouts/application.html.slim', <<-SLIM
doctype 5
html(lang="en")
  head
    meta(charset="utf-8")
    meta(http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1")
    meta(name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no")
    title = content_for?(:title) ? "\#{yield(:title)} | #{@app_name.capitalize}" : "#{@app_name.capitalize}"
    = csrf_meta_tags
    = stylesheet_link_tag "application", media: "all"
    /! Le HTML5 shim, for IE6-8 support of HTML elements
    /![if lt IE 9]
      = javascript_include_tag "//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.js"
    = javascript_include_tag "application"
    = favicon_link_tag

  body class=content_for(:body)
    nav.navbar.navbar-inverse.navbar-fixed-top
      .container-fluid
        .navbar-header
          = link_to "#{@app_name.capitalize}", root_path, class: 'navbar-brand'
        ul.nav.navbar-nav.navbar-right
          = render 'layouts/shared/you'

    #main
      #side-menu
        nav
          = link_to root_url,
            class: active_if(controller: :home),
            title: 'Home',
            data: { toggle: 'tooltip', placement: 'right' }
            i.fa.fa-home.fa-fw

      - if content_for?(:sidebar)
        #sidebar
          = yield(:sidebar)

      #content class=("without-sidebar" unless content_for?(:sidebar))
        = yield

      = bootstrap_flash

    = content_for :modal
SLIM

create_file 'app/views/layouts/devise.html.slim', <<-SLIM
doctype 5
html(lang="en")
  head
    meta(charset="utf-8")
    meta(http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1")
    / meta(name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no")
    title = content_for?(:title) ? "\#{yield(:title)} | #{@app_name.capitalize}" : "#{@app_name.capitalize}"
    = csrf_meta_tags
    = stylesheet_link_tag "application", media: "all"
    /! Le HTML5 shim, for IE6-8 support of HTML elements
    /![if lt IE 9]
      = javascript_include_tag "//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.js"
    = javascript_include_tag "application"
    = favicon_link_tag

  body class=content_for(:body)
    nav.navbar.navbar-inverse.navbar-fixed-top
      .container-fluid
        .navbar-header
          = link_to "#{@app_name.capitalize}", root_path, class: 'navbar-brand'
        ul.nav.navbar-nav.navbar-right
          = render 'layouts/shared/you'

    #main
      #content.without-sidebar.without-sidemenu
        = yield

      = bootstrap_flash
SLIM

run 'mkdir -p app/assets/javascripts/components && touch app/assets/javascripts/components/.gitkeep'
run 'mkdir -p app/assets/javascripts/pages && touch app/assets/javascripts/components/.gitkeep'
remove_file 'app/assets/javascripts/application.js'
create_file 'app/assets/javascripts/application.js.coffee', <<-COFFEESCRIPT
# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require nprogress
#= require nprogress-turbolinks
#= require action_form
#= require bootstrap
#= require zen-admin
#= require_self
#= require_tree ./components
#= require_tree ./pages

$(document).on 'ready page:load', ->
  NProgress.configure showSpinner: false
COFFEESCRIPT

run 'mkdir -p app/assets/stylesheets/components && touch app/assets/stylesheets/components/.gitkeep'
run 'mkdir -p app/assets/stylesheets/pages && touch app/assets/stylesheets/components/.gitkeep'
remove_file 'app/assets/stylesheets/application.css'
create_file 'app/assets/stylesheets/application.css.sass', <<-SASS
//= require _bootstrap-sprockets
//= require _bootstrap
//= require font-awesome
//= require nprogress
//= require nprogress-bootstrap
//= require zen-admin

@import "bourbon"
@import "zen-admin/variables"
@import "zen-admin/mixins"
SASS
inject_into_file ".gitignore", "\n/config/database.yml", :after => "/.bundle"
inject_into_file ".gitignore", "\n.DS_Store", :after => "/.bundle"
run "cp config/database.yml config/database.yml.example"

gsub_file '.rspec', '--color', '--color --format NyanCatFormatter'

run 'mkdir -p app/views/layouts/shared'
create_file 'app/views/layouts/shared/_you.html.slim', <<-SLIM
- if user_signed_in?
  li.dropdown
    = link_to '#', class: 'dropdown-toggle you', data: { toggle: 'dropdown' }
      = gravatar_tag current_user.email, secure: request.ssl?, size: 25, html: { class: "img-rounded" }
      | &nbsp;
      span.caret
    ul.dropdown-menu
      li = link_to 'Sign Out', destroy_user_session_path, method: :delete
- else
  li
    = link_to 'Sign In', new_user_session_path
SLIM
