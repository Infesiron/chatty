require "rails_helper"

RSpec.describe Room, type: :model do
  subject { described_class.new(title: "Main") }

  context "associations" do
    it "has many messages" do
      assc = described_class.reflect_on_association(:messages)
      expect(assc.macro).to eq :has_many
    end
  end

  context "validations" do
    it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

    it "is not valid without title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end
end
