# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  last_name       :string
#  name            :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  attributes :name, :last_name, :full_name, :username, :token

  def full_name
    "#{object.name} #{object.last_name}"
  end

  def token
    Auth::JsonWebToken.encode(object.to_token)
  end
end
