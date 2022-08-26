# frozen_string_literal: true

module Attributes
  module Users
    class Create < Types::BaseInputObject
      argument :name, String, required: true
      argument :email, String, required: true
    end
  end
end
