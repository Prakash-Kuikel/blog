# frozen_string_literal: true

module Posts
  class Deleter < ApplicationService
    def call
      current_user.posts.find(params[:id]).destroy!
    end
  end
end
