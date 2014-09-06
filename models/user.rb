class User < ActiveRecord::Base
  before_save :sanitize_phone
  enum role: [:resident, :guest]

  def greeting
    "Hey there, #{name}!"
  end

  private
  def sanitize_phone
    self.phone = phone.gsub(/[^\d]/, '').gsub(/^1/, '') if self.phone
  end
end
