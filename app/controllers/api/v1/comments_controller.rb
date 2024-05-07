# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[create]

      def create
        tweet = Tweet.find_by(id: params[:id])
        comment = tweet.comments.build(comment_param)
        comment.user_id = current_api_v1_user.id
        comment.save!
        render json: { tweet: }, include: [:comments], status: :ok
      end

      private

      def comment_param
        params.require(:comment).permit(:content)
      end
    end
  end
end
