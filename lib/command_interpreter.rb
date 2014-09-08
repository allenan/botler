class CommandInterpreter
  class << self
    def parse(text)
      text = text.downcase
      task_keywords.each do |task, keywords|
        keywords.each do |keyword|
          if text.include?(keyword)
            message = perform(task, with: text)
            return message
          end
        end
      end
    end

    private

    def task_keywords
      {
        'add_user' => ['add resident', 'add guest']
      }
    end

    def perform(task, with: raise)
      "Tasks::#{task.camelize}".constantize.new(with).perform
    end
  end
end
