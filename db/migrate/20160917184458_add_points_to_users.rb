class AddPointsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :points, :integer, :default => 100
  end
end
