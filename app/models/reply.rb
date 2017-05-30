class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :riv
  has_many :likes
end
