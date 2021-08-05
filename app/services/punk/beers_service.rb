module Punk
  class BeersService
    def initialize(user)
      @user = user
      @connection = Faraday.new(url: endpoint)
    end

    def lookup(**args)
      if args.key?(:abv)
        avb = args[:abv]
        args.delete(:abv)
        args[:abv_lt] = abv + 0.1
        args[:abv_gt] = abv - 0.1
      end
      response @connection.get('', args)
    end

    def get_beer(id)
      res = @connection.get('', {ids: id})
      save_beer(JSON.parse(res.body))
      res
    end

    def get_all
      
    end

    private

    def save_beer(beers)
      beers.each do |beer|
        new_beer = Beer.find_or_create_by(beer_fields(beer))
        if new_beer.present?
          asso = @user.user_beer.find_or_create_by(beer: new_beer)
          asso.update(seen_at: Time.now) if asso.present?
        end
      end
    end

    def beer_fields(payload)
      payload.slice('name', 'tagline', 'description', 'abv')
    end
    
    def endpoint
      @endpoin ||= 'https://api.punkapi.com/v2/beers'.freeze
    end
  end
end