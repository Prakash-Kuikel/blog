# frozen_string_literal: true

module Posts
  class Updater < ApplicationService
    def call
      current_user.posts.find(params.delete(:id)).update!(params)
    end
  end
end
