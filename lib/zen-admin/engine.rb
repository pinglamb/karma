module ZenAdmin
  class Engine < ::Rails::Engine
    initializer 'zen-admin.assets.precompile' do |app|
      %w(stylesheets javascripts zen-admin-libs).each do |sub|
        app.config.assets.paths << root.join('assets', sub).to_s
      end
    end
  end
end
