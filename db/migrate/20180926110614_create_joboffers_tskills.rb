class CreateJoboffersTskills < ActiveRecord::Migration[5.1]
  def change
    create_table :joboffers_tskills do |t|
      t.integer :tskill_id
      t.integer :joboffer_id
    end
  end
end
