# frozen_string_literal: true

module Users
  class Updater < ApplicationService
    def call
      User.find(params.delete(:id)).update!(params)
    end
  end
end
