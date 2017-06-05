class FilterPhotos
  def initialize(headers)
    @headers = headers
    @access_token = headers['X-Instagram-Access-Token']
    @request_data = nil
    @inst_posts = []
    @user_id = headers['X-User-Id']
  end

  attr_reader :request_data, :access_token, :headers, :user_id
  attr_accessor :inst_posts

  def show_pictures
    get_self_media_req
    serialize_posts(request_data['data'])
    compare_photos
    !inst_posts.empty? && create_photos
    filter_and_show_user_photos
  end

  private

  def compare_photos
    photos = User[user_id].pictures

    # photos.each do |user_photo|
    #   inst_posts.each do |inst_photo|
    #     if  inst_photo[:post_id] == user_photo.inst_id
    #       inst_posts.delete(inst_photo)
    #     end
    #   end
    # end

    photos.each { |user_photo| inst_posts.each { |inst_photo| inst_photo[:post_id] === user_photo.inst_id && inst_posts.delete(inst_photo) } }
  end

  def create_photos
    inst_posts.each do |post|
      Picture.create(
          user_id: user_id,
          address: post[:url],
          inst_id: post[:post_id]
      )
    end
  end

  def filter_and_show_user_photos;
    photos = User[user_id].pictures
    new_arr = []
    # photos.map { |photo| !photo.item_id.nil? && photos.delete(photo)}
    photos.each { |photo| photo.item_id.nil? && new_arr.push(photo) }
    new_arr
  end

  def serialize_posts(posts)
    posts.map do |post|
      data = {
          post_id: post['id'],
          url: post['images']['standard_resolution']['url']
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

# 1. Fetch profile's photos
# 2. Compare instagram photos with saved photos
# 3. Save new photos if the are exist otherwise skip this step
# 4. Render saved photos to user with their attributes