module Tasks
  def self.try_task
    begin
      yield
    rescue => e
      return "Something went wrong :(\n#{e.message}"
    end
  end
end
