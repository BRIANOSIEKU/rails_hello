module Api
  module V1
    class FactsController < ApplicationController
      before_action :set_fact, only: [:show, :update, :destroy, :like]

      MAX_PER_PAGE = 50

      # GET /api/v1/facts
      def index
        # Get pagination params from query string, with defaults
        page = params.fetch(:page, 1).to_i
        per_page = [params.fetch(:per_page, 10).to_i, MAX_PER_PAGE].min

        # Fetch paginated facts
        facts = Fact.order(created_at: :desc)
                    .offset((page - 1) * per_page)
                    .limit(per_page)

        # Total count for metadata
        total_count = Fact.count

        # Render JSON with metadata
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
          render json: @fact.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/facts/:id
      def update
        if @fact.update(fact_params)
          render json: @fact
        else
