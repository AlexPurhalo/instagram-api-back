class Users < Grape::API
  get 'auth/instagram/callback' do
    user = FindInstagramUser.new(params[:code])

    user.setup_user_data && user.has_correct_data? ?
        user.exist? ? user.show_token : user.create && user.show_token:
        user.error_msg
  end

  get 'me' do
    me =  MyInstagramInfo.new(headers)
    me.show_info
  end

  get 'users/:user_id' do
    user = UserInstagramInfo.new(params, headers)
    user.show_info
  end

  get 'my_photos' do
    photos = MyInstagramPhotos.new(headers)
    photos.show_pictures
  end
end
