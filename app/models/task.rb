class Task < ApplicationRecord
  belongs_to :category

  validates :title, :notes, :date, presence: true
end
