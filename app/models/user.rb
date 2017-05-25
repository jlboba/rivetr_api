class User < ApplicationRecord
  # rivs the user has posted themselves
  has_many :rivs
  # replies the user has posted themselves
  has_many :replies

  # other users that follow the user being looked at
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower

  # other users that the user being looked at is following
  has_many :followed_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee

end
