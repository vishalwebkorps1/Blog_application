class Post < ApplicationRecord
    validates :tittle, presence: true, length: {minimum: 5 , maximum: 50}
    validates :body, presence: true, length: {minimum: 10 , maximum: 50}
    belongs_to :user
    has_many :comments, dependent: :destroy
end