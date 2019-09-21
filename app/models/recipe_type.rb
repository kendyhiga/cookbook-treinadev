# frozen_string_literal: true

# Recype Types class, to classify the recipes
class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true
end
