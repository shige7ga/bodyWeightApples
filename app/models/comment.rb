class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 2000 }

  belongs_to :user
  belongs_to :weight_record
end
