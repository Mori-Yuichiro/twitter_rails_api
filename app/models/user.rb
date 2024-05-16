# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable
  include DeviseTokenAuth::Concerns::User

  include Rails.application.routes.url_helpers

  has_many :comments, dependent: :destroy

  has_many :retweets, dependent: :destroy

  has_many :tweets, dependent: :destroy

  has_one_attached :profile_image
  has_one_attached :header_image

  def profile_image_url
    return unless profile_image.attached?

    url_for(profile_image)
  end

  def header_image_url
    return unless header_image.attached?

    url_for(header_image)
  end

  def retweet_tweet
    # リツイートしたツイートの情報を取得
    retweet_ids = retweets.pluck(:tweet_id)
    retweet_tweet = Tweet.find(retweet_ids)
    # リツイートしたツイートのユーザー情報を取得
    retweet_user_ids = retweet_tweet.pluck(:user_id)
    retweet_user = User.find(retweet_user_ids)
    [retweet_tweet, retweet_user]
  end
end
