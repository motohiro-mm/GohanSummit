# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'tailwindcss-stimulus-components' # @6.0.2
pin 'stimulus-textarea-autogrow' # @4.1.0
pin '@stimulus-components/clipboard', to: '@stimulus-components--clipboard.js' # @5.0.0

pin 'service_worker_installer', preload: true
