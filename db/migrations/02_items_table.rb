Sequel.migration do
  up do
    create_table :items do
      primary_key :id

      String :name
      String :price
      String :description
      String :price_kind

      foreign_key :user_id, :users
    end
  end

  down do; drop_table :items; end
end
