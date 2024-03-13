# frozen_string_literal: true

#
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def set_public_id
    self.public_id = SecureRandom.uuid if respond_to?("public_id=")
  end

  def display_name
    name.presence || "#{self.class.model_name.human} #{id}"
  end

  def as_event_data
    as_json(except: [:id, :created_at, :updated_at])
  end

  # Создать/обновить запись из пришедшего события
  def self.create_or_update_from_event(data)
    attributes_from_event = data.stringify_keys.except("id", "public_id", "created_at", "updated_at").slice(*column_names)

    record = create_with("role" => "", "name" => "", **attributes_from_event).find_or_create_by!(public_id: data["public_id"])
    record.update!(attributes_from_event)

    Rails.logger.debug "#{record.class.name} created or updated from #{data}"

    record
  end
end
