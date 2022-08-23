# frozen_string_literal: true

module GraphqlHelper
  def current_user
    context[:current_user]
  end

  def current_locale
    I18n.locale.to_s
  end
end
