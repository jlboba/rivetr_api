class User < ApplicationRecord
  # rivs the user has posted themselves
  has_many :rivs
  # replies the user has posted themselves
  has_many :replies
end
