# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_many :notifications, dependent: :destroy

  validates :content, presence: true

  after_create_commit :create_notification

  private

  def create_notification
    return if user_id == tweet.user_id

    notification = Notification.new(visitor_id: user_id, visited_id: tweet.user_id, comment_id: id, action: :comment)
    return unless notification.save
  end
end
