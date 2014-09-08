class Sms
  require 'twilio-ruby'

  attr_reader :recipients

  def initialize(to: raise, message: raise)
    @recipients = Array(to)
    @message = message
  end

  def send!
    recipients.each do |user|
      client.messages.create(
        from: '+17042885372',
        to:   '+1' + user.phone,
        body: message
      )
    end
  end

  private

  def client
    account_sid = 'AC9085c0270f19e3166c63f91684a9810a'
    auth_token = 'ee1dbfbcfb66d1455932eaa25f6ff049'

    @client ||= Twilio::REST::Client.new account_sid, auth_token
  end
end
