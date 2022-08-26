# frozen_string_literal: true

module Users
  class Updater < ApplicationService
    attr_accessor :id, :name, :email

    def call
      user = User.find(id)
      user.update!(name: name, email: email)
    end
  end
end
