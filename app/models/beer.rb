# == Schema Information
#
# Table name: beers
#
#  id          :bigint           not null, primary key
#  abv         :float
#  description :string
#  name        :string
#  tagline     :string
#
class Beer < ApplicationRecord
  has_many :user_beers
end
