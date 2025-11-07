# POST /api/v1/facts/:id/like
def like
  @fact = Fact.find(params[:id])

  if @fact.liked_user_ids.include?(@current_user.id)
    render json: { error: "You already liked this fact" }, status: :forbidden
  else
    @fact.liked_user_ids << @current_user.id
    @fact.likes += 1
    if @fact.save
      render json: @fact, status: :ok
    else
      render json: { error: "Unable to like fact" }, status: :unprocessable_entity
    end
  end
end
