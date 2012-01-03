Sequel.migration do
  up do
    drop_column :notes, :body
    add_column :notes, :body, :text
  end

  down do
    # Nope
  end
end
