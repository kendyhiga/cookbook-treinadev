class Cuisine < ApplicationRecord
  has_many :cuisine

  validates :name, presence: true, uniqueness: true
end