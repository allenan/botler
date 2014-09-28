class SmsJob
  include SuckerPunch::Job

  def perform(sms)
    sms.send!
  end
end
