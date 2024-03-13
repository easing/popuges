module EDA
  # Событие
  class Event
    attr_reader :version, :errors

    class << self
      def topic(value)
        @topic = value.to_s
      end

      def version(value = 1)
        @version = value.to_i
      end

      def from_payload(payload)
        instance = new(payload["data"], version: payload["event_version"])
        instance.instance_variable_set :@payload, payload

        instance
      end
    end

    def initialize(params = {}, version: self.class.version)
      @params = params
      @version = version.to_i
    end

    def topic = self.class.instance_variable_get(:@topic)

    def id = payload["event_id"]

    def name = payload["event_name"]

    def data = payload["data"]

    def payload
      @payload ||= {
        event_id: SecureRandom.uuid,
        event_name: self.class.name.gsub(/::V\d+/, ""),
        event_time: Time.current.to_s,
        event_version: version,
        producer: Rails.application.class.name&.deconstantize&.downcase,
        data: @params.as_json
      }.with_indifferent_access.freeze
    end

    def as_json
      {
        topic: topic,
        payload: payload.to_json
      }
    end

    def valid?
      @errors ||= EDA.registry.validate(self)
      @errors.empty?
    end
  end
end
