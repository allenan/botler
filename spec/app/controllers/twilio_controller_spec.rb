require 'spec_helper'

A_RESIDENT_PHONE  = '+13334445566'
A_GUEST_PHONE     = '+14445556677'
AN_UNKNOWN_PHONE  = '+15556667788'

RSpec.describe "TwilioController" do
  let(:sms) { double(:sms).as_null_object }

  before do
    User.destroy_all
    allow(Door).to receive(:open!)
    allow(Sms).to receive(:new) { sms }
  end

  after do
    post 'twilio/voice', twilio_params
  end

  context "when user is a resident" do
    let(:twilio_params) { {'From' => A_RESIDENT_PHONE} }

    before do
      User.resident.create(name: "Test", phone: A_RESIDENT_PHONE)
    end

    it "opens the door" do
      expect(Door).to receive(:open!)
    end
  end

  context "when user is a guest" do
    let(:twilio_params) { {'From' => A_GUEST_PHONE} }
    let(:user) { User.guest.create(name: "Test", phone: A_GUEST_PHONE) }

    before do
      allow(User).to receive(:find_by) { user }
    end

    it "opens the door" do
      expect(Door).to receive(:open!)
    end

    it "sends all residents an sms" do
      expect(Sms).to receive(:new).with(
        to: User.resident,
        message: "#{user.name} has arrived"
      )

      expect(sms).to receive(:send!)
    end
  end

  context "when user is unknown" do
    let(:twilio_params) { {'From' => AN_UNKNOWN_PHONE} }

    it "does not open the door" do
      expect(Door).not_to receive(:open!)
    end

    it "initiates a conference call"
  end
end
