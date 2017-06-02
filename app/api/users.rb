class Users < Grape::API
  get 'auth/instagram/callback' do
    user = FindInstagramUser.new(params[:code])

    if user.setup_user_data && user.has_correct_data?
      !user.exist? && user.create
      @me = user.data
      @inst_token = user.inst_token
      render rabl: 'users/me'
    else
      user.error_msg
    end
  end

  get 'instagram_profile' do
    me =  MyInstagramInfo.new(headers)
    me.show_info
  end

  get 'me' do
    @me = User[headers['X-User-Id']]
    render rabl: 'users/me'
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
