require 'csv'

require 'natto'

class Natto::MeCab
  # 構文解析の結果を配列で返却
  def morphemes(string)
    parse(string).each_line.map{ |l| l[/^(.*?)\t/, 1] }.compact
  end
end

class MarkovTable5
  BEGIN_WORD = '__BEGIN__'
  END_WORD = '__END__'
  TWEET_LENGTH = 100

  def initialize(csv_file)
    @word_list = Hash.new(Hash.new(Hash.new({})))
    generate(csv_file)
  end

  def generate_tweet()
    tweet = ''
    w1 = BEGIN_WORD
    w2 = BEGIN_WORD
    w3 = BEGIN_WORD
    w4 = BEGIN_WORD
    w5 = @word_list[w1][w2][w3][w4].sample
    loop do
      tweet << w5
      w1, w2, w3, w4 = w2, w3, w4, w5
      w5 = @word_list[w1][w2][w3][w5].sample
      break if w5 == END_WORD
      break if (tweet + w5).length >= TWEET_LENGTH
    end
    return tweet
  end

  private

  def generate(tweets_csv_file)
    natto = Natto::MeCab.new()
    CSV.foreach(tweets_csv_file) do |tweet|
      w1 = BEGIN_WORD
      w2 = BEGIN_WORD
      w3 = BEGIN_WORD
      w4 = BEGIN_WORD
      tmp = Array.new
      tmp << BEGIN_WORD
      tmp.concat(natto.morphemes(tweet[2]))
      tmp << END_WORD

      tmp.each do |t|
        w5 = t
        create_markov_table(w1, w2, w3, w4, w5)
        w1, w2, w3, w4 = w2, w3, w4, w5
      end
    end
  end

  def create_markov_table(w1, w2, w3, w4, w5)
    return if w5 == BEGIN_WORD
    if @word_list[w1][w2][w3][w4].nil?
      @word_list[w1][w2][w3][w4] = Array.new([w5])
    else
      @word_list[w1][w2][w3][w4] << w5
    end
  end
end
