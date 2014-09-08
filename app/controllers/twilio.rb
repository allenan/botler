Butler::App.controllers :twilio do
  disable :layout

  class UnknownUser
    def greeting; "Hi there!"; end
    def resident?; false; end
    def guest?; false; end
  end

  before do
    content_type 'text/xml'
    @user = User.find_by(phone: sanitize_phone(params['From'])) || UnknownUser.new
  end

  post :voice do
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

  post :sms do
    if @user.resident?
      result = CommandInterpreter.parse(params['Body'])
      Sms.new(to: @user, message: result).send!
    end
    render ''
  end
end
