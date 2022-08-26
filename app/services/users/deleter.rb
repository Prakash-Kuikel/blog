# frozen_string_literal: true

module Users
  class Deleter < ApplicationService
    attr_accessor :id

    def call
      User.find(id).destroy!
    end
  end
end
