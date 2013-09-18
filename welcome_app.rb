require 'twilio-ruby'
require 'sinatra'
require 'rack-flash'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  erb :index
end

post '/submit' do

  @account_sid = ""
  @auth_token = ""

  @client = Twilio::REST::Client.new(@account_sid, @auth_token)

  @account = @client.account
  @message = @account.sms.messages.create(
    {
      :from => '',
      :to => '',
      :body => "#{params[:name]}'s installfest went #{params[:answer]}."
    }
  )

  flash[:notice] = "SMS sent: #{@message}"
  redirect '/'
end
