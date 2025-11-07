module Api
  module V1
    class FactsController < ApplicationController
      before_action :set_fact, only: [ :show, :update, :destroy, :like ]

      MAX_PER_PAGE = 50

      # GET /api/v1/facts
      def index
        page = params.fetch(:page, 1).to_i
        per_page = [ params.fetch(:per_page, 10).to_i, MAX_PER_PAGE ].min

        facts = Fact.order(created_at: :desc)
                    .offset((page - 1) * per_page)
                    .limit(per_page)

        total_count = Fact.count

        render json: {
          metadata: {
            total_count: total_count,
            page: page,
            per_page: per_page
          },
          facts: facts
        }
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
          render json: { errors: @fact.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/facts/:id
      def update
        if @fact.update(fact_params)
          render json: @fact
        else
          render json: { errors: @fact.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/facts/:id
      def destroy
        if @fact.destroy
          head :no_content
        else
          render json: { errors: { fact: [ "could not be deleted" ] } }, status: :unprocessable_entity
        end
      end

      # POST /api/v1/facts/:id/like
      def like
        user_id = request.headers["X-User-Id"]
        if user_id.blank?
          return render json: { errors: { user: [ "X-User-Id header missing" ] } }, status: :unauthorized
        end

        if @fact.liked_user_ids.include?(user_id)
          return render json: { errors: { like: [ "You already liked this fact" ] } }, status: :forbidden
        end

        @fact.liked_user_ids << user_id
        @fact.increment(:likes)
        if @fact.save
          render json: @fact, status: :ok
        else
          render json: { errors: @fact.errors }, status: :unprocessable_entity
        end
      end

      private

      def set_fact
        @fact = Fact.find_by(id: params[:id])
        render json: { errors: { fact: [ "not found" ] } }, status: :not_found unless @fact
      end

      def fact_params
        params.require(:fact).permit(:content, :user_id)
      end
    end
  end
end
