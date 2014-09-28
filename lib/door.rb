class Door
  def self.open!(actor: nil)
    core.function("buzz", "4")
    Event.create(type: 'door_open', actor: actor) if actor
  end

  def self.ring
    Sms.new(
      to: User.resident,
      message: "Someone just rang the doorbell. Should I let them in?"
    ).send_async
    Event.create(type: 'doorbell_ring')
    DoorObserverJob.new.async.perform
  end

  private

  def self.core
    RubySpark::Core.new(ENV['SPARK_DOOR_BUZZER_DEVICE_ID'])
  end
end
