# frozen_string_literal: true

# Recype List class, this is a join table to connect Recipes and Lists
class RecipeList < ApplicationRecord
  belongs_to :recipe
  belongs_to :list

  validates :recipe, presence: true,
                     uniqueness: { scope: :list }
  validates :list, presence: true,
                   uniqueness: { scope: :recipe }
end
