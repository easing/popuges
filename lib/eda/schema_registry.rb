module EDA
  # Реестр схем
  class SchemaRegistry
    def initialize(root_path)
      @root_path = root_path

      # TODO: загружать все схемы при инициализации
      @schemas = {}

      load_schemas
    end

    # @param [EDA::Event] event
    def schema_for(event)
      @schemas[schema_key_for(event)]
    end

    def schema_key_for(event)
      "#{event.name.underscore}/#{event.version}.json"
    end

    def validate(event)
      JSON::Validator.fully_validate(schema_for(event), event.payload)
    end

    private

    # Загрузить все схемы
    def load_schemas
      Dir
        .glob(Rails.root.join(@root_path, "**/*.json"))
        .map do |schema_path|
          event_key = schema_path.gsub(Rails.root.join(@root_path).to_s, "").gsub(/\A\//, "")
          @schemas[event_key] ||= File.read(schema_path)
        end
    end
  end
end
