require "rails_helper"

RSpec.describe Message, type: :model do
  let(:user) { User.new(email: "test@mail.com", password: "qwerty",
     password_confirmation: "qwerty") }
  let(:room) { Room.new(title: "Main") }

  subject { described_class.new(body: "Hello world!", user: user,
                                room: room) }

  context "associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to room" do
      assc = described_class.reflect_on_association(:room)
      expect(assc.macro).to eq :belongs_to
    end
  end

  context "validations" do
    it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

    it "is not valid without body" do
      subject.body = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without user" do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without room" do
      subject.room = nil
      expect(subject).to_not be_valid
    end
  end
end
