class Fact < ApplicationRecord
  belongs_to :user
  validates :fact, presence: true
  validates :likes, numericality: { greater_than_or_equal_to: 0 }

  # Store liked_user_ids as an array
  attribute :liked_user_ids, :json, default: []
end
