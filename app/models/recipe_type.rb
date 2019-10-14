# frozen_string_literal: true

# Recype Types class, to classify the recipes
class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
