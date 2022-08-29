# frozen_string_literal: true

module Posts
  class Updater < ApplicationService
    def call
      post = Post.find(params.delete(:id))
      authorize! post, to: :update?
      post.update!(params)
    end
  end
end
