class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates :username, uniqueness: true

  # def self.limit_ten(user)
  #   ten_tweets = user[0..9]
  # end

  def fetch_tweets!
    Twitter.user_timeline(username).each do |tweet|
      unless Tweet.where(twitter_user_id: self.id).find_by_content(tweet.text)  
        self.tweets << Tweet.create(content: tweet.text)
      end
    end
  end

  # def fetch_tweets!
  #   # reads from tweets table
  # end

end

  # def self.find_by_username(username)
  #   user_tweets = []
  #   Twitter.user_timeline(username).each do |tweet| 
  #     user_tweets << tweet.text
  #   end
  #   user_tweets
  # end
