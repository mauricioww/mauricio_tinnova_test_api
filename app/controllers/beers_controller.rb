class BeersController < ApplicationController
  before_action :authenticate!
  before_action :initalize_beer_service!

  def index
    response = @beer_service.get_all
    render json: {
        hello: @current_user.name
    }
  end

  def show
    response = @beer_service.get_beer(beer_params['id'])
    render json: {
      status: response.status,
      beer: JSON.parse(response.body)
    }
  end

  def mark_favorite
  end

  def get_all
    seen = UserBeer.where(user: @current_user)
    beers = Beer.joins(:user_beers).merge(seen)
    render json: {
      status: 200 ,
      seen_beers: beers 
    }
  end

  def my_favorites
    seen = UserBeer.where(user: @current_user, favorite: true)
    beers = Beer.joins(:user_beers).merge(seen)
    render json: {
      status: 200,
      favorites_beers: beers 
    }
  end

  private

  def initalize_beer_service!
    @beer_service ||= Punk::BeersService.new(@current_user) 
  end

  def beer_params
    params.permit(:id, :name, :abv, :page)
  end
end
