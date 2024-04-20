# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index create]
      def index
        page = (params[:offset].to_i / params[:limit].to_i) + 1
        tweets = Tweet.page(page).per(params[:limit]).order(created_at: 'DESC')
        total_page = tweets.total_pages
        render json: { tweet: tweets, total_page: }, include: [:user], status: :ok, methods: [:image_urls]
      end

      def create
        tweet = current_api_v1_user.tweets.build(tweet_param)
        if tweet.save
          render json: { tweet: }, status: :ok, methods: [:image_urls]
        else
          render json: { tweet: tweet.errors }, status: :unprocessable_entity
        end
      end

      private

      def tweet_param
        params.require(:tweet).permit(:content)
      end
    end
  end
end
