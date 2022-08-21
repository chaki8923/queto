class Word < ApplicationRecord
  belongs_to :user

  validates :term, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :conversion, presence: true
end
