get '/' do
  erb :index
end

post '/' do
  redirect "/#{params[:username]}"
end

get "/:username" do
  p params[:username]
  
  if @user = TwitterUser.find_by_username(params[:username])
  else
    @user = TwitterUser.create(username: params[:username])
  end

  @tweets = @user.fetch_tweets!
  
  id = @user.id
  update_time = Tweet.where(twitter_user_id: id).last.updated_at
  
  if @user.tweets.empty?
    @tweets = @user.fetch_tweets!
    if (Time.now - update_time) > 900
      @user.fetch_tweets!
    end 
  end  

  @last_ten_tweets = @tweets[0..9] 

  erb :show_tweets
end

# We need to flag when the cache is stale
#  and re-fetch the data if it's stale.
#  Let's say for now that the cache is stale if 
# we've fetched the recent tweets within the la
# st 15 minutes. Change your controller code to work thus:
