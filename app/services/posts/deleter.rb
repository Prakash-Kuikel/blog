# frozen_string_literal: true

module Posts
  class Deleter < ApplicationService
    def call
      post = Post.find(params[:id])
      authorize! post, to: :delete?
      post.destroy!
    end
  end
end
