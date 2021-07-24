class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :title, presence: true
  validates :comment, presence: true
  validates :rate, presence: true
end
