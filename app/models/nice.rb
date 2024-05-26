# frozen_string_literal: true

class Nice < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_many :notifications, dependent: :destroy

  validates :user_id, uniqueness: { scope: :tweet_id }

  include NotificationConcern
  after_create_commit :create_notification

  # private

  # def create_notification
  #   return if user_id == tweet.user_id

  #   notification = Notification.new(visitor_id: user_id, visited_id: tweet.user_id, nice_id: id, action: :nice)
  #   return unless notification.save
  # end
end
