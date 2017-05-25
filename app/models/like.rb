class Like < ApplicationRecord
  belongs_to :user
  belongs_to :riv, optional: true
  belongs_to :reply, optional: true
end
