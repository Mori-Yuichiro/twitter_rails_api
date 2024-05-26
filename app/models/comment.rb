# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_many :notifications, dependent: :destroy

  validates :content, presence: true

  include NotificationConcern
  after_create_commit :create_notification
end
