# == Schema Information
#
# Table name: user_beers
#
#  id       :bigint           not null, primary key
#  favorite :boolean          default(FALSE)
#  seen_at  :datetime
#  beer_id  :bigint
#  user_id  :bigint
#
# Indexes
#
#  index_user_beers_on_beer_id  (beer_id)
#  index_user_beers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (beer_id => beers.id)
#  fk_rails_...  (user_id => users.id)
#
class UserBeer < ApplicationRecord
  belongs_to :user
  belongs_to :beer
end
