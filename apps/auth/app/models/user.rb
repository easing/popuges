# frozen_string_literal: true

class User < ::ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  include ::UserRoles

  after_initialize :set_public_id, if: :new_record?

  # TODO: вынести изменение роли и регистрацию пользователей в отдельные интекракшены
  after_commit :stream_role_change, if: :saved_change_to_role?
  after_commit :stream_user_registration, on: :create

  private

  # @return [Rdkafka::Producer::DeliveryHandle]
  def stream_role_change
    UserRoleChanged.new(public_id: public_id, role: role, name: name).stream
  end

  # @return [Rdkafka::Producer::DeliveryHandle]
  def stream_user_registration
    UserRegistered.new(public_id: public_id, role: role, name: name).stream
  end
end
