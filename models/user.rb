class User < ActiveRecord::Base
  before_save :sanitize_phone
  enum role: [:resident, :guest]

  validates_presence_of :name

  def greeting
    "Hey there, #{name}!"
  end

  def first_name
    name.split(' ').first
  end

  private
  def sanitize_phone
    self.phone = phone.gsub(/[^\d]/, '').gsub(/^1/, '') if self.phone
  end
end
