class ThingsController < ApplicationController
  def index
    render json: Thing.all
  end

  def create
    render json: Thing.create!(thing_params)
  end

  def show
    render json: thing
  end

  def update
    thing.update!(thing_params)

    render json: thing
  end

  def destroy
    thing.destroy

    head :no_content
  end

  private

  def thing_params
    params.permit(:name)
  end

  def thing
    @thing ||= Thing.find(params[:id])
  end
end
