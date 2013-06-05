require 'bundler'
Bundler.setup(:default)
Bundler.require

load 'user.rb'

get '/' do
  erb :home
end

get '/user' do
  @user = User.new(params[:username])
  @song = @user.last_song

  erb :user
end
