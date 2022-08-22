# frozen_string_literal: true

class ApplicationService
  attr_accessor :args

  def initialize(args = {})
    @args = args.to_h
  end

  def self.call(args = {})
    new(args).call
  end
end
