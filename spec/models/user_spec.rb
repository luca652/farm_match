require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: "Marco") }

  it 'has a name' do
    expect(user.name).to eq("Marco")
  end
end
