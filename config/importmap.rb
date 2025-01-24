pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@popperjs/core', to: 'https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js', preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true

pin_all_from 'app/javascript/views', under: 'views'
