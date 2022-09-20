class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = bird_id_obj
    render json: bird
  end

  # PATCH /birds/:id
  def update
    bird = bird_id_obj
    bird.update(bird_params)
    render json: bird
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = bird_id_obj
    bird.update(likes: bird.likes + 1)
    render json: bird
  end

  # DELETE /birds/:id
  def destroy
    bird = bird_id_obj
    bird.destroy
    head :no_content
  end

  private

  def bird_id_obj
    Bird.find(id: params[:id])
  end 

  def error_message
    render json: { error: "Bird not found" }, status: :not_found
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
