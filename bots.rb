require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like

class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    self.consumer_key = ENV["consumer_key_#{username}"] # Your app consumer key
    self.consumer_secret = ENV["consumer_secret_#{username}"] # Your app consumer secret
    self.delay_range = 1..6
  end

  def on_startup
    @model = Ebooks::Model.load("model/#{username}.model")
    scheduler.every '10m' do
      tweet(@model.make_statement(140))
    end
  end

  def on_mention(tweet)
    reply(tweet, @model.make_statement(140))
  end
end

# Make a MyBot and attach it to an account
MyBot.new("fake_jaris") do |bot|
  bot.access_token = ENV["access_token_fake_jaris"] # Token connecting the app to this account
  bot.access_token_secret = ENV["access_token_secret_fake_jaris"] # Secret connecting the app to this account
end
