require 'rdio_api'

class User

  def initialize(username)
    @username = username
  end

  def last_song
    song = user_data['lastSongPlayed']
    {
      :icon   => song['icon'],
      :url    => song['url'],
      :artist => song['albumArtist'],
      :title  => song['name']
    }
  end

  def heavy_rotation
    key = user_data[:heavyRotationKey]
    hr  = client.get(:keys => key)
    hr[key][:tracks].map do |t|
      {
        :title  => t[:album],
        :artist => t[:artist],
        :url    => t[:albumUrl]
      }
    end.uniq
  end

  def url
    "http://rdio.com#{account_url}"
  end

  private

  def client
    @client ||= RdioApi.new(:consumer_key => 'n89y2yxfrdek38tsv6st72sg', :consumer_secret => 'WzP6z4Qf9u')
  end

  def user_data
    @user_data ||= client.findUser(:vanityName => @username, :extras => 'lastSongPlayed, heavyRotationKey')
  end

  def account_url
    user_data[:url]
  end
end
