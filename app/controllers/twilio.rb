Butler::App.controllers :twilio do

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

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
