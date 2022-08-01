class Word < ApplicationRecord
  belongs_to :user

  validates :term, presence: true, length: { minimum: 2 }
  validates :conversion, presence: true
end
