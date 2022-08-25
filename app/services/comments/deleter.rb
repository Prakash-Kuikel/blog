# frozen_string_literal: true

module Comments
  class Deleter < ApplicationService
    def call
      Comment.find(params[:id]).destroy!
    end
  end
end
