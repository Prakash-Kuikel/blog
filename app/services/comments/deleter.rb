# frozen_string_literal: true

module Comments
  class Deleter < ApplicationService
    def call
      comment = Comment.find(params[:id])
      authorize! comment, to: :delete?
      comment.destroy!
    end
  end
end
