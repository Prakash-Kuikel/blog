# frozen_string_literal: true

module Users
  class Creator < ApplicationService
    attr_accessor :name, :email

    def call
      User.create!(name: name, email: email)
    end
  end
end
