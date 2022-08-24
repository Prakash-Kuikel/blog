# frozen_string_literal: true

module Users
  class Deleter < ApplicationService
    def call
      User.find(params[:id]).destroy!
    end
  end
end
