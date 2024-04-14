# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[create]
      def create
        tweet = current_api_v1_user.tweets.build(tweet_param)
        if tweet.save
          render json: { tweet: }, status: :ok
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
