class AddAcceptedToAnswers < ActiveRecord::Migration[5.0]
  def change
  	add_column :answers, :accepted, :boolean
  	add_index :answers, :accepted
  end
end
