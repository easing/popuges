require 'json/schema/serializer'
require 'json_refs'

module EDA
  class Serializer
    # @param [JSON::Schema] schema
    def initialize(schema)
      @serializer = JSON::Schema::Serializer.new JsonRefs.(schema.schema)
    end

    # @param [Hash] payload
    def serialize(payload)
      @serializer.serialize(payload)
    end
  end
end