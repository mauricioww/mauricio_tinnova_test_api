module Punk
  class BeersService
    def initialize(user)
      @user = user
      @connection = Faraday.new(url: endpoint)
    end

    def lookup(args)
      parsed_args = {
        beer_name: (args['name'] if args['name'].present?),
        abv_lt: ((args['abv'].to_f + 0.1) if args['abv'].present?),
        abv_gt: ((args['abv'].to_f - 0.1) if args['abv'].present?)
      }.compact
      # binding.pry
      res = @connection.get('', parsed_args)
      if res.success?
        save_beer(JSON.parse(res.body))
      end
      res
    end

    def get_beer(id)
      res = @connection.get('', {ids: id})
      if res.success?
        save_beer(JSON.parse(res.body))
      end
      res
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