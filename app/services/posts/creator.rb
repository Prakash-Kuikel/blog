# frozen_string_literal: true

module Posts
  class Creator < ApplicationService
    def call
      current_user.posts.create!(params)
    end
  end
end
