# frozen_string_literal: true

module Comments
  class Creator < ApplicationService
    def call
      current_user.comments.create!(params)
      # Post.find(params.delete(:post_id)).comments.create!({ **params, user_id: current_user.id })
    end
  end
end
