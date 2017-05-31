class FindInstagramUser
  def initialize(session_code)
    @session_code = session_code
    @request, @user_data, @error_msg = nil
  end

  attr_reader :session_code, :request
  attr_accessor :user_data, :error_msg

  # TODO: change error message
  def setup_user_data
    request_to_api['code'].nil? ? (@user_data = {
        inst_token:    request['access_token'],
        inst_uid:      request['user']['id'],
        inst_username: request['user']['username'],
        inst_avatar:   request['user']['profile_picture']
    }) : (@error_msg = 'Something wrong with Instagram authentication')
  end

  def has_correct_data?; !user_data.nil?; end

  def exist?; !User.where(inst_uid: user_data[:inst_uid]).first.nil?; end

  def create
    User.create(
        username:    user_data[:inst_username],
        inst_uid:    user_data[:inst_uid],
        inst_avatar: user_data[:inst_avatar],
        inst_token:  user_data[:inst_token]
    )
  end

  def show_token
    {
        token: User.where(inst_uid: user_data[:inst_uid]).first.jwt,
        inst_token: user_data[:inst_token]
    }
  end

  private
  def request_to_api
    begin
      request_to_api = RestClient.post('https://api.instagram.com/oauth/access_token', {
          :client_id     => 'b2c21614a6854184af420c92673f46e9',
          :client_secret => '62c8f80662f34492ac386352b7b49077',
          :redirect_uri  => 'http://localhost:8080/',
          :code          => session_code,
          :grant_type    => 'authorization_code'
      },  :accept        => :json)

      @request = JSON.parse(request_to_api)
    rescue => e
      @request = JSON.parse(e.response)
    end
  end
end