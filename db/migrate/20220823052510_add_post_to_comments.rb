# frozen_string_literal: true

class AddPostToComments < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :comments, :post, null: false, index: { algorithm: :concurrently }
  end
end
