Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*" # Substitua '*' pelo domínio do frontend, se for necessário (ex: 'http://localhost:8080')
    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options ]
  end
end
