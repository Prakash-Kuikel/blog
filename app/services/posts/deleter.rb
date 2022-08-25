# frozen_string_literal: true

module Posts
  class Deleter < ApplicationService
    def call
      Post.find(params[:id]).destroy!
    end
  end
end
