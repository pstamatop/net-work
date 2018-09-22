class CreateTskills < ActiveRecord::Migration[5.1]
  def change
    create_table :tskills do |t|
      t.string :name

      t.timestamps
    end
  end
end
