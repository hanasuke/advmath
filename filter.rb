require 'awesome_print'
require 'csv'


original_tweet_file = ARGV[0]
filtered_tweets_file = 'tweets_filtered.csv'

original_csv_data = CSV.read(original_tweet_file)

own_tweets = []

original_csv_data.each do |csv|
  # そもそも RT,shindanmaker,swarm,hatenaなどのURLが含まれてたら対象から除外する
  unless csv[2] =~ /(RT|shindanmaker|swarmapp|b\.hatena\.ne\.jp|pixiv|youtube|gigazine|niconico|speakerdeck|slideshare|[tT]ogetter|htn\.to|b\.hatena)/
    csv[2].gsub!(/(\r\n|\n|\r|\f)/,'') # 改行文字を削除
    csv[2].gsub!(/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/,'') # URLを排除
    csv[2].gsub!(/@[A-Za-z0-9_]+/, '') # Twitterユーザ名を削除
    csv[2].gsub!(/#[\w]+/, '') # ハッシュタグを削除
    own_tweets << csv
  end
end

CSV.open(filtered_tweets_file, 'w') do |line|
  own_tweets.each do |t|
    line << t
  end
end
