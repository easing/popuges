# frozen_string_literal: true

##
class User::CreatedConsumer < EDA::Consumer
  version 1 do |event|
    User.create_or_update_from_event(event.data)
  end
end
