class MyInstagramPhotos
  def initialize(headers)
    @headers = headers
    @access_token = headers['Inst-Token']
    @request_data = nil
    @inst_posts = []
  end

  attr_reader :request_data, :access_token, :headers
  attr_accessor :inst_posts

  def show_pictures
    get_self_media_req
    serialize_posts(request_data['data'])
    inst_posts
  end

  private

  def serialize_posts(posts)
    posts.map do |post|
      data = {
          post_id: post['id'],
          img: post['images']['standard_resolution']['url']
      }
      inst_posts.push(data)
    end
  end

  def get_self_media_req
    begin
      req_response = RestClient.get(
          "https://api.instagram.com/v1/users/self/media/recent/?access_token=#{access_token}"
      )
      @request_data = JSON.parse(req_response)
    rescue => e
      @request_data = JSON.parse(e.response)
    end
  end
end