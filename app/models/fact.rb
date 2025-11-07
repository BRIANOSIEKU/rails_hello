class Fact < ApplicationRecord
  belongs_to :user
  validates :fact, presence: true
  validates :likes, numericality: { greater_than_or_equal_to: 0 }

  # This allows Rails to store liked_user_ids as an Array
  serialize :liked_user_ids, Array
end
