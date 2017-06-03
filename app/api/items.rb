class Items < Grape::API
  resources :items do
    get '/' do
      @items = User[headers['X-User-Id']].items
      render rabl: 'items/all'
    end

    post '/' do
      item_processing = CreateItem(headers)
      @items = item_processing.show_all
      render rabl: 'items/all'
    end
  end
end