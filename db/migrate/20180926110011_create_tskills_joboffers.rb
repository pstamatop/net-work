class CreateTskillsJoboffers < ActiveRecord::Migration[5.1]
  def change
    create_table :tskills_joboffers do |t|
      t.integer :tskill_id
      t.integer :joboffer_id
    end
  end
end
