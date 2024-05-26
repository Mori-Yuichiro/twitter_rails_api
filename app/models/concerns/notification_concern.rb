# frozen_string_literal: true

module NotificationConcern
  extend ActiveSupport::Concern

  def create_notification
    if instance_of?(::Relationship)
      return if follower_id == followed_id

      notification = Notification.new(visitor_id: follower_id, visited_id: followed_id,
                                      nice_id: id, action: 'follow')
    else
      return if user_id == tweet.user_id

      notification = Notification.new(visitor_id: user_id, visited_id: tweet.user_id, nice_id: id,
                                      action: self.class.name.downcase)
    end
    return unless notification.save
  end
end
