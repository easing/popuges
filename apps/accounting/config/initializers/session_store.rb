Rails.application.config.session_store :active_record_store,
                                       :key => "_#{Rails.app_class.name.deconstantize.downcase}_session"
