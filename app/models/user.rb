class User < ApplicationRecord
  has_many :rivs
  has_many :replies
end
