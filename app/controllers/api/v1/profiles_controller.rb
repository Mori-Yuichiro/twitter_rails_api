# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[show update]

      def show
        user = User.find_by(id: params[:id])
        render json: { user: }, status: :ok, methods: %i[profile_image_url header_image_url retweet_tweet],
               include: { tweets: { methods: %i[image_urls retweets_count], include: :retweets }, comments: {} }
      end

      def update
        current_api_v1_user.update!(profile_params)
        if params[:user][:headerImageData] && params[:user][:headerFileName]
          blob = add_image(params[:user][:headerImageData], params[:user][:headerFileName])
          current_api_v1_user.header_image.attach(blob)
        end

        if params[:user][:profileImageData] && params[:user][:profileFileName]
          blob = add_image(params[:user][:profileImageData], params[:user][:profileFileName])
          current_api_v1_user.profile_image.attach(blob)
        end
        render json: { user: current_api_v1_user }, status: :ok, methods: %i[profile_image_url header_image_url]
      end

      private

      def profile_params
        params.require(:user).permit(:name, :bio, :birthday, :location, :website)
      end

      def add_image(file_data, file_name)
        ActiveStorage::Blob.create_and_upload!(
          io: StringIO.new(Base64.decode64(file_data.split(',').last)),
          filename: file_name
        )
      end
    end
  end
end
