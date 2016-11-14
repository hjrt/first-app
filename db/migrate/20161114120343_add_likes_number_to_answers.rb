class AddLikesNumberToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :likes_number, :integer, :default => 0
    add_index :answers, :likes_number
  end
end
