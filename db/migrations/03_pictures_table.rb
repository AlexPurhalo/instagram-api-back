Sequel.migration do
  up do
    create_table :pictures do
      primary_key :id

      String :inst_id
      String :address

      foreign_key :item_id, :items
    end
  end

  down do; drop_table :pictures; end
end