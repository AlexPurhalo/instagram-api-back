collection @items
attributes :id, :name, :price, :description,:price_kind

child :pictures => :photos do
  attributes :id, :inst_id, :address
end