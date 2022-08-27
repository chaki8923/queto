class Word < ApplicationRecord
  belongs_to :user

  validates :term, presence: true,uniqueness: true
  validates :conversion, presence: true
end
