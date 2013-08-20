class CreateTweet < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user
      t.string :content
      t.timestamps
    end
  end
end
