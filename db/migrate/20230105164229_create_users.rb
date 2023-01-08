class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :strava_uid
      t.float :brubank, default: 0
      t.float :beers_drunk, default: 0
      t.float :beers_earned, default: 0

      t.timestamps
    end
  end
end
