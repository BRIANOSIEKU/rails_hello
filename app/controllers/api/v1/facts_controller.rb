class Api::V1::FactsController < ApplicationController
  # Before doing create, update, or delete — check if user is authenticated
  before_action :authenticate_user, only: [:create, :update, :destroy]
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
    @fact = @current_user.facts.build(fact_params)
    if @fact.save
      render json: @fact, status: :created
    else
      render json: @fact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/facts/:id
  def update
    if @fact.user_id == @current_user.id
      if @fact.update(fact_params)
        render json: @fact
      else
        render json: @fact.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Forbidden: You cannot modify another user's fact" }, status: :forbidden
    end
  end

  # DELETE /api/v1/facts/:id
  def destroy
    if @fact.user_id == @current_user.id
      @fact.destroy
      head :no_content
    else
      render json: { error: "Forbidden: You cannot delete another user's fact" }, status: :forbidden
    end
  end

  private

  def set_fact
    @fact = Fact.find(params[:id])
  end

  def fact_params
    params.require(:fact).permit(:fact, :likes)
  end

  # This method checks for a valid X-User-Id in request headers
  def authenticate_user
    user_id = request.headers["X-User-Id"]

    # Try to find the user in the database
    @current_user = User.find_by(id: user_id)

    # If user doesn't exist or header missing, reject the request
    unless @current_user
      render json: { error: "Unauthorized: Missing or invalid X-User-Id header" }, status: :unauthorized
    end
  end
end
