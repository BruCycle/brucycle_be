require 'rails_helper'

RSpec.describe Activity do
  attrs = {
    id: 1234,
    start_date: "2023-01-04T21:20:44Z",
    distance: 37.0,
    start_latlng: [39.734417013823986, -105.00263798050582],
    name: "Afternoon Run"
  }
  activity = Activity.new(attrs)

  it 'exists' do
    expect(activity).to be_an Activity
    expect(activity.strava_id).to eq(1234)
    expect(activity.date).to eq("2023-01-04T21:20:44Z")
    expect(activity.distance).to eq(37.0)
    expect(activity.latitude).to eq(39.734417013823986)
    expect(activity.longitude).to eq(-105.00263798050582)
    expect(activity.title).to eq("Afternoon Run")
  end
end