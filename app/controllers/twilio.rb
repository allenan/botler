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
      Door.open!(actor: @user)
    elsif @user.guest?
      Door.open!(actor: @user)
      Sms.new(
        to: User.resident,
        message: "#{@user.name} has arrived"
      ).send_async
    else
    end
    render :voice
  end

  post :sms do
    if @user.resident?
      result = CommandInterpreter.parse(params['Body'], actor: @user)
      Sms.new(to: @user, message: result).send!
    end
    render :sms
  end
end
