class Items < Grape::API
  resources :items do
    get '/' do
      User[headers['X-User-Id']].items
    end
  end
end