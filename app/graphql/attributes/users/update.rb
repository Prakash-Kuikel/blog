# frozen_string_literal: true

module Attributes
  module Users
    class Update < Types::BaseInputObject
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
    end
  end
end
