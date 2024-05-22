# frozen_string_literal: true

module Api
  module V1
    module Users
      class FollowsController < ApplicationController
        before_action :authenticate_api_v1_user!, only: %i[create]

        def create
          user = User.find_by(id: params[:user_id])
          current_api_v1_user.follow(user)
          render status: :ok
        end
      end
    end
  end
end
