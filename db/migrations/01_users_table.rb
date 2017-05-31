Sequel.migration do
  up do
    create_table :users do
      primary_key :id

      String :username, null: false
      String :inst_uid
      String :inst_avatar
      String :jwt
    end
  end

  down do
    drop_table :users
  end
end