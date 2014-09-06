class Sms
  attr_reader :recipients

  def initialize(to: raise, message: raise)
    @recipients = Array(to)
  end

  def send!
  end
end
