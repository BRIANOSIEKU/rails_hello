module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /api/v1/users
      def index
        users = User.all
        render json: users, status: :ok
      end

      # GET /api/v1/users/:id
      def show
        if @user
          render json: @user, status: :ok
        else
          render json: { error: "User not found" }, status: :not_found
        end
      end

      # POST /api/v1/users
      def create
        user = User.new(user_params)
        if user.save
          render json: { message: "User created successfully", user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/users/:id
      def update
        if @user.update(user_params)
          render json: { message: "User updated successfully", user: @user }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/users/:id
      def destroy
        if @user.destroy
          head :no_content   # ✅ Returns HTTP 204, as required by tests
        else
          render json: { error: "Failed to delete user" }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find_by(id: params[:id])
      end

      def user_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end
