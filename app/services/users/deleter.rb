# frozen_string_literal: true

module Users
  class Deleter < ApplicationService
    def call
      user = User.find(params[:id])
      authorize! user, to: :delete?
      user.destroy!
    end
  end
end
