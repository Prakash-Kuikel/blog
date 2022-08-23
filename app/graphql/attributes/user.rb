# frozen_string_literal: true

module Attributes
  class User < Types::BaseInputObject
    argument :name, String, required: true
    argument :email, String, required: true
  end
end
