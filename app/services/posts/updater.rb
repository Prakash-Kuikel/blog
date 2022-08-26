# frozen_string_literal: true

module Posts
  class Updater < ApplicationService
    def call
      Post.find(params.delete(:id)).update!(params)
    end
  end
end
