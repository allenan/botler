class CommandInterpreter
  class << self
    def parse(text)
      task_keywords.each do |task, keywords|
        keywords.each do |keyword|
          perform(task, with: text) if text.include?(keyword)
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
