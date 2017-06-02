class Picture < Sequel::Model
  many_to_one :item
  many_to_one :user
end