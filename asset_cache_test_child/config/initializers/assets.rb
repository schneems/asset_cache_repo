# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
module AssetCacheTest
  Application.configure do
    config.assets.version = '1.0'

    config.assets.manifest = Rails.root.join('public/assets/sprockets-manifest.json')

    config.assets.configure do |env|
      # We want Sprockets logs in our Rails logs.
      env.logger = Rails.logger

      env.cache = ActiveSupport::Cache::FileStore.new("#{env.root}/tmp/cache/sprockets-4.0")
    end
  end
end
