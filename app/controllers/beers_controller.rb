class BeersController < ApplicationController
  before_action :authenticate!
  before_action :initalize_beer_service!
  before_action :load_seen_beers, only: %i(get_all my_favorites mark_favorite)

  def index
    response = @beer_service.lookup(beer_params)
    render json: {
      status: response.status,
      beer: JSON.parse(response.body)
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
    asso = UserBeer.find_by(beer_id: beer_params['id'])
    render json: { status: '500' } if asso.blank?
    asso.update(favorite: true)
    render json: {
      status: 200,
      favorite: asso.favorite,
      beer: asso.beer
    }
  end

  def get_all
    beers = Beer.joins(:user_beers).merge(@seen_beers)
    render json: {
      status: 200 ,
      seen_beers: beers 
    }
  end

  def my_favorites
    beers = Beer.joins(:user_beers).merge(@seen_beers.where(favorite: true))
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

  def load_seen_beers
    @seen_beers = UserBeer.where(user: @current_user)
  end
end
