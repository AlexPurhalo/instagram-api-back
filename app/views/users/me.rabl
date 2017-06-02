object @me
attributes :id, :username, :inst_avatar, :jwt
node(:inst_token) { |token| @inst_token }
node(:items_count) { |items| User[:id].items.count }
