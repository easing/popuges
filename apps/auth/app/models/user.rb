# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  role                   :string           default("guest"), not null
#  public_id              :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
class User < ::ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           inverse_of: :resource_owner,
           dependent: :delete_all

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           inverse_of: :resource_owner,
           dependent: :delete_all

  include ::UserRoles

  after_initialize :set_public_id, if: :new_record?

  # Produced Events
  after_commit(on: :create) do
    EDA.stream User::Registered.new(as_event_data)
    EDA.stream User::Created.new(as_event_data)
  end

  after_commit(on: :update) { EDA.stream(User::Updated.new(as_event_data)) }

  after_commit(if: :saved_change_to_role?) do
    ::EDA.stream User::RoleChanged.new(as_event_data)
  end

  def as_event_data
    { public_id: public_id, role: role, name: name }
  end
end
