module UserConcern
  extend ActiveSupport::Concern

  included do
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

    def encrypted_password; end

    def email; end

    def encrypted_password=(value) end

    def self.from_omniauth(auth)
      create_with(public_id: auth.info.user.public_id, role: auth.info.user.role, name: auth.info.user.name)
        .find_or_create_by!(public_id: auth.info.user.public_id)
    end
  end
end
