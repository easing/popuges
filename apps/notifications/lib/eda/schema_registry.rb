# frozen_string_literal: true

module EDA
  # Реестр схем
  class SchemaRegistry
    def initialize(root_path)
      @schemas = load_schemas(root_path)
    end

    # @param [String] event_name
    # @param [Integer] version
    def schema_for(event_name, version: 1)
      @schemas[schema_key_for(event_name, version: version)]
    end

    # @param [String] event_name
    # @param [Integer] version
    def schema_key_for(event_name, version: 1)
      "#{event_name.underscore}/#{version}.json"
    end

    private

    def load_schemas(root_path)
      Rails.root
           .glob("#{root_path}/**/*.json")
           .inject({}) { |schemas, schema_path|
             event_key = schema_path.to_s.gsub(Rails.root.join(root_path).to_s, "").gsub(/\A\//, "")
             schemas[event_key] ||= JSON::Schema::Reader.new.read(schema_path)
             schemas
           }
    end
  end
end
