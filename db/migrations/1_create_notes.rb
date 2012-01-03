Sequel.migration do
  up do
    create_table(:notes) do
      primary_key :id
      String :author
      String :body, :null => false
      String :address
      DateTime :time, :null => false, :index => true
    end
  end

  down do
    drop_table(:notes)
  end
end
