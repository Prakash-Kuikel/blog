# frozen_string_literal: true

module Users
  class Deleter < ApplicationService
    def call
      User.find_by(params).destroy!
    end
  end
end
