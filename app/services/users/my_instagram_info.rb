class MyInstagramInfo
  def initialize(headers)
    @current_user_id, @inst_token = headers['X-User-Id'], headers['X-Instagram-Access-Token']
    @request, @user_data, @error_msg = nil
  end

  attr_reader :current_user_id, :inst_token, :request

  def show_info; request_to_api && request; end

  private
  def current_user; User[current_user_id]; end

  # TODO: handle errors
  def request_to_api
    begin
      request_to_api = RestClient.get(
          "https://api.instagram.com/v1/users/self/?access_token=#{inst_token}"
      )
      @request = JSON.parse(request_to_api)
    rescue => e
      @request = JSON.parse(e.response)
    end
  end
end