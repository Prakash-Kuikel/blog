# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :body, presence: true
  validates_associated :user
end
