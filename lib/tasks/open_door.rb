module Tasks
  class OpenDoor
    def initialize(text, actor)
      @text = text
      @actor = actor
    end

    def perform
      if any_doorbell_rings?
        Door.open!(actor: @actor)
      end
    end

    private
    def any_doorbell_rings?
      Event.where(
        type: 'doorbell_ring',
        created_at: 1.minute.ago..Time.current
      ).any?
    end

  end
end
