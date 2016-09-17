class AddColumnIsAcceptedToQuestions < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :accepted, :boolean, :default => false
  	add_index :questions, :accepted
  end
end
