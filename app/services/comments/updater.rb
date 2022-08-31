# frozen_string_literal: true

module Comments
  class Updater < ApplicationService
    def call
      comment = Comment.find(params.delete(:id))
      authorize! comment, to: :update?
      comment.update!(params)
    end
  end
end
