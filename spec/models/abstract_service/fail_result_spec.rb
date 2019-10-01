# frozen_string_literal: true

describe AbstractService::FailResult do
  it "fail result return errors" do
    result = AbstractService::FailResult.new("user not found")
    expect(result.errors).to eq("user not found")
  end
end
