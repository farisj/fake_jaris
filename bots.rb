require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like

class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  FREQUENCY = {
    'real_jaris' => '2h',
    'BotAshton' => '1h'
  }

  def configure
    self.consumer_key = ENV["consumer_key_#{username}"] # Your app consumer key
    self.consumer_secret = ENV["consumer_secret_#{username}"] # Your app consumer secret
    self.delay_range = 1..6
  end

  def on_startup
    @model = Ebooks::Model.load("model/#{username}.model")
    scheduler.every FREQUENCY[username] do
      tweet(@model.make_statement(140))
    end
  end

  def on_mention(tweet)
    reply(tweet, @model.make_statement(140))
  end
end

# Make a MyBot and attach it to an account
MyBot.new("real_jaris") do |bot|
  bot.access_token = ENV["access_token_real_jaris"] # Token connecting the app to this account
  bot.access_token_secret = ENV["access_token_secret_real_jaris"] # Secret connecting the app to this account
end

MyBot.new("BotAshton") do |bot|
  bot.access_token = ENV["access_token_BotAshton"] # Token connecting the app to this account
  bot.access_token_secret = ENV["access_token_secret_BotAshton"] # Secret connecting the app to this account
end
