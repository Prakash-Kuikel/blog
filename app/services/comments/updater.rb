# frozen_string_literal: true

module Comments
  class Updater < ApplicationService
    def call
      Comment.find(params.delete(:id)).update!(params)
    end
  end
end
