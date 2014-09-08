require 'spec_helper'

RSpec.describe Tasks::AddUser do
  before { User.destroy_all }

  context "with the correct command text" do
    it "creates a user" do
      Tasks::AddUser.new("add resident Test Testerson 7776665544").perform
      user = User.first
      expect(user.name).to eq("Test Testerson")
      expect(user.phone).to eq("7776665544")
      expect(user.role).to eq("resident")
    end

    it "returns a successful message" do
      message = Tasks::AddUser.new("add resident Test Testerson 7776665544").perform
      expect(message).to eq("I added Test Testerson to the guest list!")
    end
  end

  context "with incorrect command text" do
    it "returns a failure message" do
      message = Tasks::AddUser.new("add resident").perform
      expect(message).to eq("Something went wrong :(\nValidation failed: Name can't be blank")
    end
  end
end
