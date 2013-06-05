require 'bundler'
Bundler.setup(:default)
Bundler.require

get '/' do
  erb :home
end

get '/user' do
  username = params[:username]

  @song     = get_last_song_from(username)
  @user_url = url_from(username)
  erb :user
end

def get_last_song_from(username)
  song = user_data(username)['lastSongPlayed']
  {
    :icon   => song['icon'],
    :url    => song['url'],
    :artist => song['albumArtist'],
    :title  => song['name']
  }
end

def url_from(username)
  "http://rdio.com#{user_data(username)[:url]}"
end

def user_data(username)
  @user_data ||= client.findUser(:vanityName => username, :extras => 'lastSongPlayed')
end

def client
  @client ||= RdioApi.new(:consumer_key => 'n89y2yxfrdek38tsv6st72sg', :consumer_secret => 'WzP6z4Qf9u')
end
