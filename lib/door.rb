class Door
  def self.open!
    core.function("buzz", "4")
  end

  private

  def self.core
    RubySpark::Core.new(ENV['SPARK_DOOR_BUZZER_DEVICE_ID'])
  end
end
