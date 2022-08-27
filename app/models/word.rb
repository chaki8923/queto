class Word < ApplicationRecord
  belongs_to :user

  # validates :term,  
  validates :conversion, presence: true
end
