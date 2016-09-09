class AddColumnIsAcceptedToQuestions < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :accepted, :boolean
  	add_index :questions, :accepted
  end
end
