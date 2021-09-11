class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :text

      t.integer :poll_id
      t.timestamps
    end
    add_index :questions, :poll_id
  end
end
