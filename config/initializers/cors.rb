require 'rack'
require 'rack/cors'

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :delete, :put, :patch ]
    end
  end