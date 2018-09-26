class CreateApplies < ActiveRecord::Migration[5.1]
  def change
    create_table :applies do |t|
      t.references :user, foreign_key: true
      t.references :joboffer, foreign_key: true

      t.timestamps
    end
  end
end
