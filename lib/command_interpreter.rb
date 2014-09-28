class CommandInterpreter
  class << self
    def parse(text, actor: nil)
      text = text.downcase
      task_keywords.each do |task, keywords|
        keywords.each do |keyword|
          if text.include?(keyword)
            message = perform(task, with: text, as: actor)
            return message
          end
        end
      end
    end

    private

    def task_keywords
      {
        'add_user' => ['add resident', 'add guest'],
        'open_door' => ['yes']
      }
    end

    def perform(task, with: raise, as: nil)
      "Tasks::#{task.camelize}".constantize.new(with, as).perform
    end
  end
end
