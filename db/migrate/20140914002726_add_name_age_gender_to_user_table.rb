class AddNameAgeGenderToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string, :limit => 1
  end
end
