class AddMoreColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :blood_type, :string
    add_column :users, :education, :string
  end
end
