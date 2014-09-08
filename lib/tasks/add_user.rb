module Tasks
  class AddUser
    def initialize(text)
      @text = text
    end

    def perform
      Tasks::try_task do
        user = User.create!(
          name:  parse_name,
          phone: parse_phone,
          role:  parse_role
        )
        return "I added #{user.name} to the guest list!"
      end
    end

    private

    def parse_name
      @text.split(' ')[2..-2].join(' ').titleize
    end

    def parse_phone
      @text.split(' ')[-1]
    end

    def parse_role
      @text.split(' ')[1]
    end
  end
end
