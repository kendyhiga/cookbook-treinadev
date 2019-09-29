# frozen_string_literal: true

# Registered user class
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, dependent: :restrict_with_exception
  has_many :lists, dependent: :restrict_with_exception

  def can_edit?(recipe = nil)
    return false if recipe.nil?

    (recipe && self) == recipe.user || admin?
  end
end
