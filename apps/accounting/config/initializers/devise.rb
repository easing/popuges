# frozen_string_literal: true

require_relative "../../../../lib/doorkeeper_strategy"

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.authentication_keys = []
  config.case_insensitive_keys = []
  config.strip_whitespace_keys = []

  config.skip_session_storage = [:http_auth, :doorkeeper]

  # ==> OmniAuth
  config.omniauth :doorkeeper,
                  ENV['DOORKEEPER_APP_ID'],
                  ENV['DOORKEEPER_SECRET_ID'],
                  scope: 'default',
                  strategy_class: ::DoorkeeperStrategy

  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
