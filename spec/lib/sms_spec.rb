require 'spec_helper'

A_MESSAGE = 'this is a message'

RSpec.describe Sms do
  let(:sms) { described_class.new(params) }

  before do
    User.destroy_all
    @resident_1 = User.resident.create(name: 'Resident 1' )
    @resident_2 = User.resident.create(name: 'Resident 2' )
  end

  describe "#initialize" do
    context "where message is to residents" do
      let(:params) { { to: User.resident, message: A_MESSAGE } }

      it "assigns all residents as recipients" do
        expect(sms.recipients).to include(@resident_1)
        expect(sms.recipients).to include(@resident_2)
      end

      it "sends an sms to all recipients"
    end
  end
end
