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
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           inverse_of: :resource_owner,
           dependent: :delete_all # or :destroy if you need callbacks

  include ::UserRoles

  after_initialize :set_public_id, if: :new_record?

  # TODO: вынести изменение роли и регистрацию пользователей в отдельные интекракшены
  after_commit :stream_role_change, if: :saved_change_to_role?
  after_commit :stream_user_registration, on: :create

  private

  # @return [Rdkafka::Producer::DeliveryHandle]
  def stream_role_change
    UserRoleChanged.new({ public_id: public_id, role: role, name: name }).stream
  end

  # @return [Rdkafka::Producer::DeliveryHandle]
  def stream_user_registration
    UserRegistered.new({ public_id: public_id, role: role, name: name }).stream
  end
end
