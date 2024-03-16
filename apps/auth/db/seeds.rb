# frozen_string_literal: true

User.roles.each do |role_name, _|
  User.create!(
    name: role_name,
    email: "#{role_name}@easing.ru",
    password: role_name,
    password_confirmation: role_name,
    role: role_name
  )
end

Doorkeeper::Application.create!(name: "accounting", scopes: "default", redirect_uri: "https://accounting.popuges.easing.ru/users/auth/doorkeeper/callback", uid: "m60uKqBNFBqIL435DAgXInTMw02Kdsllb_hgx4eGj5M", secret: "BSUgDZG6EhjREPFqZBP7mfJFtbzrMqD3_71RfyI43hU")
Doorkeeper::Application.create!(name: "analytics", scopes: "default", redirect_uri: "https://analytics.popuges.easing.ru/users/auth/doorkeeper/callback", uid: "qQ41BGrm4XICI8qK0I7Pc0tJotNPjGWQMxKucOsvqhs", secret: "BSUgDZG6EhjREPFqZBP7mfJFtbzrMqD3_71RfyI43hU")
Doorkeeper::Application.create!(name: "notifications", scopes: "default", redirect_uri: "https://notifications.popuges.easing.ru/users/auth/doorkeeper/callback", uid: "erSn4By1vuRDygDvFl79zahbUsfBxhuEWUZipFRSq4M", secret: "BSUgDZG6EhjREPFqZBP7mfJFtbzrMqD3_71RfyI43hU")
Doorkeeper::Application.create!(name: "tasks", scopes: "default", redirect_uri: "https://tasks.popuges.easing.ru/users/auth/doorkeeper/callback", uid: "iy-sQH3SyV3LlDXpnvZrwazSKYDgrUNOG_1SIcCLN68", secret: "BSUgDZG6EhjREPFqZBP7mfJFtbzrMqD3_71RfyI43hU")