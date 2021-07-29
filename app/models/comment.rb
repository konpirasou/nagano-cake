class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :title, presence: true
  validates :comment, presence: true
  validates :rate, presence: true

  def self.review_persent(star,comment)
    case star
    when 5
      (comment.where("rate = 5").count.to_f / comment.pluck(:rate).count.to_f * 100).to_i
    when 4
      (comment.where("rate = 4").count.to_f / comment.pluck(:rate).count.to_f * 100).to_i
    when 3
      (comment.where("rate = 3").count.to_f / comment.pluck(:rate).count.to_f * 100).to_i
    when 2
      (comment.where("rate = 2").count.to_f / comment.pluck(:rate).count.to_f * 100).to_i
    when 1
      (comment.where("rate = 1").count.to_f / comment.pluck(:rate).count.to_f * 100).to_i
    end
  end

end
