# frozen_string_literal: true

module Users
  class Creator < ApplicationService
    def call
      User.create!(params)
    end
  end
end
