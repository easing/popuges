# frozen_string_literal: true

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
    def schema_for(event_name, version: 1)
      @schemas[schema_key_for(event_name, version: version)]
    end

    # @param [String] event_name
    # @param [Integer] version
    def schema_key_for(event_name, version: 1)
      "#{event_name.underscore}/#{version}.json"
    end

    private

    # Загрузить все схемы
    def load_schemas
      Rails.root
           .glob("#{@root_path}/**/*.json")
           .each { |schema_path|
             event_key = schema_path.to_s.gsub(Rails.root.join(@root_path).to_s, "").gsub(/\A\//, "")
             @schemas[event_key] ||= JSON::Schema::Reader.new.read(schema_path)
           }
    end
  end
end
