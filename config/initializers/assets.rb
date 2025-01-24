Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules/bootstrap/dist/js')
Rails.application.config.assets.paths << Rails.root.join('node_modules/bootstrap-icons/font')
Rails.application.config.assets.paths << Rails.root.join('node_modules/bootstrap/dist/js')

Rails.application.config.assets.precompile << 'bootstrap.min.js'
