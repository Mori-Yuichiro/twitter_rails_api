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
  has_many :tweets, through: :retweets

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
end
