class UserInstagramInfo
  def initialize(params, headers)
    @user_id, @inst_token = params[:user_id], headers['Inst-Token']
    @request = nil
  end

  attr_reader :user_id, :inst_token, :request

  def show_info
    request_to_api && request
  end

  private
  def user; User[user_id]; end

  def request_to_api
    begin
      request_to_api = RestClient.get(
          "https://api.instagram.com/v1/users/#{user.inst_uid}/?access_token=#{user.inst_token}"
      )
      @request = JSON.parse(request_to_api)
    rescue => e
      @request = JSON.parse(e.response)
    end
  end
end