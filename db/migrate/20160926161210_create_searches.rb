class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :user
      t.string :post
      t.string :answer

      t.timestamps
    end
  end
end
