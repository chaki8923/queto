class Word < ApplicationRecord
    belongs_to :user

    validates :term, presence: true
    validates :conversion, presence: true
end
