require 'twitter'
require 'dotenv/load'

require_relative './markov_table2.rb'
require_relative './markov_table3.rb'
require_relative './markov_table4.rb'
require_relative './markov_table5.rb'

# initialize client
client = Twitter::REST::Client.new do |c|
  c.consumer_key = ENV['CONSUMER_KEY']
  c.consumer_secret = ENV['CONSUMER_SECRET']
  c.access_token  = ENV['ACCESS_TOKEN']
  c.access_token_secret = ENV['ACCESS_SECRET']
end

markov5 = MarkovTable5.new('./tweets_filtered.csv')
puts 'markov5 ready'
markov4 = MarkovTable4.new('./tweets_filtered.csv')
puts 'markov4 ready'
markov3 = MarkovTable3.new('./tweets_filtered.csv')
puts 'markov3 ready'
markov2 = MarkovTable2.new('./tweets_filtered.csv')
puts 'markov2 ready'

client.update(markov5.generate_tweet + ' #naosuke_markov5')
client.update(markov4.generate_tweet + ' #naosuke_markov4')
client.update(markov3.generate_tweet + ' #naosuke_markov3')
client.update(markov2.generate_tweet + ' #naosuke_markov2')
