class Door
  def self.open!
    core.function("buzz", "4")
  end

  def self.ring
    Sms.new(
      to: User.resident,
      message: "Someone just rang the doorbell"
    ).send_async
  end

  private

  def self.core
    RubySpark::Core.new(ENV['SPARK_DOOR_BUZZER_DEVICE_ID'])
  end
end
