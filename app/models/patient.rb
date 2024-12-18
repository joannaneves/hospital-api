class Patient < ApplicationRecord
  has_many :recipes, dependent: :destroy
end
