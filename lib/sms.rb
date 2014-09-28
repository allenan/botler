class Sms
  require 'twilio-ruby'

  attr_reader :recipients

  def initialize(to: raise, message: raise)
    @recipients = Array(to)
    @message = message
  end

  def send_async
    SmsJob.new.async.perform(self)
  end

  def send!
    recipients.each do |user|
      client.messages.create(
        from: '+17042885372',
        to:   '+1' + user.phone,
        body: @message
      )
    end
  end

  private

  def client
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    @client ||= Twilio::REST::Client.new account_sid, auth_token
  end
end
