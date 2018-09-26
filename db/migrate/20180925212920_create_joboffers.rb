class CreateJoboffers < ActiveRecord::Migration[5.1]
  def change
    create_table :joboffers do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :joboffers, [:user_id, :created_at]
  end
end
