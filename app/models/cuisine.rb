# frozen_string_literal: true

# Cuisine class, to classify the recipes
class Cuisine < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
