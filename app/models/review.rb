class Review < ApplicationRecord
  belongs_to :doctor

  validates :doctor, presence: true
  validates :description, presence: true
end
