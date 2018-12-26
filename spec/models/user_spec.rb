require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it "has many messages" do
      assc = described_class.reflect_on_association(:messages)
      expect(assc.macro).to eq :has_many
    end
  end
end
