require 'spec_helper'

RSpec.describe User do
  context 'before_save' do
    it "sanitizes the phone number" do
      user = User.create(name: 'Test', phone: '+15554443322')
      expect(user.phone).to eq('5554443322')
    end
  end
end
