# frozen_string_literal: true

module Users
  class Creator < ApplicationService
    attr_accessor :name, :email

    def call
      user = User.create(name: name, email: email)
      return GraphQL::ExecutionError.new('Invalid user') unless user.valid?
      return user
    end
  end
end
