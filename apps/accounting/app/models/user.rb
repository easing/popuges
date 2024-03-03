# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string           default("")
# , not null
#  role       :string           default(NULL), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ::ApplicationRecord
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:doorkeeper]

  include ::UserRoles

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def password_required?
    false
  end

  def encrypted_password
  end
  def email

  end

  def encrypted_password=(value)

  end

  def self.find_for_doorkeeper_oauth(auth, signed_user = nil)
    create_with(id: auth.uid, provider: auth.provider, uid: auth.uid, role: "")
      .create_or_find_by!(id: auth.uid, provider: auth.provider, uid: auth.uid)
  end

  def self.from_omniauth(auth)
    create_with(role: "", name: "").find_or_create_by!(id: auth.resource_owner_id) do |user|
      user.role = ""
    end
  end
end
