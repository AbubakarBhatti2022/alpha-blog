class Article < ApplicationRecord
   validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    has_one_attached :image
    validates :image, presence: { message: "must be present" }
    belongs_to :user
   
  end