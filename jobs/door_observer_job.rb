class DoorObserverJob
  include SuckerPunch::Job

  TTL_MINUTES = 1

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      while Time.current < start_time + TTL_MINUTES.minutes
        if door_open_event
          actor = door_open_event.actor
          Sms.new(
            to: all_residents - actor,
            message: "#{actor.name} opened the door"
          ).send!
          break
        end
        sleep(1)
      end
    end
  end

  private

  def start_time
    @start_time ||= Time.current
  end

  def door_open_event
    @door_open_event ||= Event.where(
      type: 'door_open',
      created_at: start_time..Time.current
    ).first
  end

  def all_residents
    Array(User.resident)
  end
end
