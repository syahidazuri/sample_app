class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  scope -> { order created_at: :desc }
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.validations.micropost.max_length }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                            size: { less_than: 5.megabytes,
                                    message: "should be less than 5MB" }
end
