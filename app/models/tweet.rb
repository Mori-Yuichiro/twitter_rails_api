# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user

  include Rails.application.routes.url_helpers

  has_many_attached :images

  validates :content, presence: true, length: { maximum: 140 }

  def image_urls
    return unless images.attached?

    images.map { |image| url_for(image) }
  end
end
