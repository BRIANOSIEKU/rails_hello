module Api
  module V1
    class FactsController < ApplicationController
      before_action :set_fact, only: [:show, :update, :destroy, :like]

      # your existing actions here...
      def index
        @facts = Fact.all
        render json: @facts
      end

      def show
        render json: @fact
      end

      def create
        @fact = Fact.new(fact_params)
        if @fact.save
          render json: @fact, status: :created
        else
          render json: @fact.errors, status: :unprocessable_entity
        end
      end

      def update
        if @fact.update(fact_params)
          render json: @fact
        else
          render json: @fact.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @fact.destroy
        head :no_content
      end

      def like
        user_id = request.headers["X-User-Id"]
        if user_id.blank?
          render json: { error: "Missing X-User-Id header" }, status: :unauthorized
          return
        end

        if @fact.like_by(user_id)
          render json: @fact, status: :ok
        else
          render json: { error: "You already liked this fact." }, status: :forbidden
        end
      end

      private

      def set_fact
        @fact = Fact.find(params[:id])
      end

      def fact_params
        params.require(:fact).permit(:content, :user_id)
      end
    end
  end
end
