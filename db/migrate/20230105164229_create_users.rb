class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :strava_uid
      t.float :brubank
      t.float :beers_drunk
      t.float :beers_earned

      t.timestamps
    end
  end
end
