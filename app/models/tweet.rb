# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :retweets, dependent: :destroy
  has_many :users, through: :retweets

  include Rails.application.routes.url_helpers

  has_many_attached :images

  validates :content, presence: true, length: { maximum: 140 }

  def image_urls
    return unless images.attached?

    images.map { |image| url_for(image) }
  end

  delegate :count, to: :retweets, prefix: true
end
