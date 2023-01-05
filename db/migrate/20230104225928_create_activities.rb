class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :strava_id
      t.datetime :date
      t.string :title
      t.float :distance
      t.float :calories_burned
      t.float :gas_money_saved
      t.float :beers_banked
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end
