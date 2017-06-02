class Photos < Grape::API
  get '/photos' do
    photos = FilterPhotos.new(headers)
    @photos = photos.show_pictures
    render rabl: 'photos/all'
  end
end