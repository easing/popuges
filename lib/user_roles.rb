module UserRoles
  extend ActiveSupport::Concern

  included do
    attribute :role, :string

    enum role: {
      administrator: 'administrator',
      accountant: 'accountant',
      manager: 'manager',
      popug: 'popug',
      guest: 'guest'
    }, _prefix: true

    before_save do
      self.role = role_was || "" if role.nil?
    end
  end
end
