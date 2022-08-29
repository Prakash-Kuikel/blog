# frozen_string_literal: true

module Comments
  class Creator < ApplicationService
    def call
      current_user.comments.create!(params)
    end
  end
end
