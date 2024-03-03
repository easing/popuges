# frozen_string_literal: true

User.roles.each do |role_name, _|
  User.create!(
    name: role_name,
    email: "#{role_name}@popuges.easing.ru",
    password: role_name,
    password_confirmation: role_name,
    role: role_name
  )
end
