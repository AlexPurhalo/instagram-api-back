class CreateItem
  def initialize(headers, params)
    @name, @description = params['title'], params['description']
    @price, @price_kind = params['price'], params['price_kind']
    @pictures = params['pictures']
    @item = nil

    @user_id = headers['X-User-Id']
  end

  attr_reader :name, :description, :price, :price_kind, :pictures, :user_id

  def show_all; create_item && add_picture && show_user_items; end

  private
  def create_item
    @item = Item.create(
        name: name,
        description: description,
        price: price,
        price_kind: price_kind,
        user_id: user_id
    )
  end

  def show_user_items; User[user_id].items; end

  def add_picture
    pictures.each do |picture|
      old_picture = Picture.where(inst_id: picture['inst_id']).first

      if old_picture.nil?
        Picture.create(
            inst_id: picture['inst_id'],
            address: picture['address'],
            user_id: user_id,
            item_id: @item.id
        )
      else
        old_picture.update(item_id: @item.id)
      end
    end
  end
end
