require 'rails_helper'

RSpec.describe Activity do
  describe 'relationships' do
    it { should belong_to :user }
  end
end