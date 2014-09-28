class Event < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  belongs_to :actor, class_name: "User"
end
