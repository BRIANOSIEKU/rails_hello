module Api
  module V1
    class FactsController < ApplicationController
      before_action :set_fact, only: [:show, :update, :destroy]

      # GET /api/v1/facts
      def index
        @facts = Fact.all
        render json: @facts
      end

      # GET /api/v1/facts/:id
      def show
        render json: @fact
      end

      # POST /api/v1/facts
      def create
        @fact = Fact.new(fact_params)
        if @fact.save
          render json: @fact, status: :created
        else
          render json: @fact.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/facts/:id
      def update
        if @fact.update(fact_params)
          render json: @fact
        else
          render json: @fact.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/facts/:id
      def destroy
        @fact.destroy
        head :no_content
      end

      private

      def set_fact
        @fact = Fact.find(params[:id])
      end

      # ✅ Strong parameters
      def fact_params
        params.require(:fact).permit(:title, :content)
      end
    end
  end
end
