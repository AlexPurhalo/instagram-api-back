Sequel.migration do
  up do
    create_table :pictures do
      primary_key :id

      String :inst_id
      String :address

      foreign_key :item_id, :items
      foreign_key :user_id, :users
    end
  end

  down do; drop_table :pictures; end
end