# frozen_string_literal: true

module Users
  class Updater < ApplicationService
    def call
      user = User.find(params.delete(:id))
      authorize! user, to: :update?
      user.update!(params)
    end
  end
end
