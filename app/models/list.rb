# frozen_string_literal: true

# List class, so that the user can store recipes
class List < ApplicationRecord
  belongs_to :user
  has_many :recipe_lists, dependent: :restrict_with_exception
  has_many :recipes, through: :recipe_lists

  validates :name, presence: true,
                   uniqueness: { scope: :user_id }
end
