# frozen_string_literal: true

class ApplicationService
  include Assigner

  attr_accessor :current_user

  def initialize(args = {})
    assign_attributes(args)
  end

  def self.call(args)
    new(args).call
  end

  def call
    raise NotImplementedError
  end
end

#        Example service
#
# class Creator < ApplicationService
#   attr_accessor :title, :body
#   def call
#     Post.create(title: title, body: body)
#   end
# end
#
# Creator.call(title: 'Lorem', body: 'landvlk')
