# frozen_string_literal: true

describe AbstractService::SuccesResult do
  let!(:user) { create(:user) }

  it "succes result return data" do
    result = AbstractService::SuccesResult.new(user)

    expect(result.data[:login]).to eq(user[:login])
  end
end
