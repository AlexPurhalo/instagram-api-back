class Users < Grape::API
  get 'auth/instagram/callback' do
    user = FindInstagramUser.new(params[:code])

    user.setup_user_data && user.has_correct_data? ?
        user.exist? ? user.show_token : user.create_and_show_token :
        user.error_msg
  end
end
