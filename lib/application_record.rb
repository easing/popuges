# frozen_string_literal: true

#
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include ::AutoStreamable

  # Создать/обновить запись из пришедшего события
  def self.create_or_update_from_event(data)
    attributes_from_event = data.slice(*column_names)

    record = create_with(attributes_from_event).create_or_find_by!(id: data["id"])
    record.update!(attributes_from_event)

    record
  end
end
