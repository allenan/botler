require 'spec_helper'

RSpec.describe CommandInterpreter do
  context "when command includes a valid keyword" do
    let(:command) { "add guest Tester" }
    let(:task) { double(:task).as_null_object }

    before { allow(Tasks::AddUser).to receive(:new) { task } }
    after { CommandInterpreter.parse(command) }

    it "calls the corresponding task" do
      expect(Tasks::AddUser).to receive(:new).with(command.downcase)
    end

    it "calls perform on the task" do
      expect(task).to receive(:perform)
    end
  end

  context "when command does not include a valid keyword" do
    it "does not call a task" do
      expect(Tasks::AddUser).not_to receive(:new)
      CommandInterpreter.parse("let me in")
    end
  end

  context "where command has mixed case keywords" do
    let(:command) { "Add Guest Tester" }
    let(:task) { double(:task).as_null_object }

    before { allow(Tasks::AddUser).to receive(:new) { task } }
    after { CommandInterpreter.parse(command) }

    it "executes the right task" do
      expect(Tasks::AddUser).to receive(:new).with(command.downcase)
    end
  end
end
