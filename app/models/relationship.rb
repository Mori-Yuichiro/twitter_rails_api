# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  has_many :notifications, dependent: :destroy

  include NotificationConcern
  after_create_commit :create_notification

  # private

  # def create_notification
  #   return if follower_id == followed_id

  #   notification = Notification.new(visitor_id: follower_id, visited_id: followed_id, follow_id: id, action: :follow)
  #   return unless notification.save
  # end
end
