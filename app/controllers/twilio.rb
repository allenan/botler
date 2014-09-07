Butler::App.controllers :twilio do
  disable :layout

  class UnknownUser
    def greeting; "Hi there!"; end
    def resident?; false; end
    def guest?; false; end
  end

  post :voice do
    content_type 'text/xml'
    #ap params
    @user = User.find_by(phone: params['From'][2..-1]) || UnknownUser.new

    if @user.resident?
      p "it's a resident"
      Door.open!
    elsif @user.guest?
      p "it's a guest"
      Door.open!
      Sms.new(to: User.resident, message: "#{@user.name} has arrived").send!
    else
      p "it's unknown"
    end
    render :voice
  end
end
