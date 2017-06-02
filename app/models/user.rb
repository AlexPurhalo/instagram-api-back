class User < Sequel::Model
  one_to_many :items

  def before_create
    self.jwt ||= "#{last_record + 1}:#{SecureRandom.hex}"
    super
  end

  def last_record;  users_exist? ? last_user.id : 0; end
  def last_user;    User.last;                       end
  def users_exist?; last_user.nil? ? false : true;   end
end