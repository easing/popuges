# frozen_string_literal: true

module EDA
  # Событие
  class Event
    attr_reader :errors

    class << self
      def topic(value)
        @topic = value.to_s
      end

      def version(value = nil)
        if value.nil?
          @version ||= 1
        else
          @version = value.to_i
        end
      end

      # @param [TrueClass] value
      def transactional!(value = "true")
        @transactional = value.to_s == "true"
      end

      def transactional?
        @transactional == true
      end

      # @param [Hash] payload
      # @return [EDA::Event]
      def from_payload(payload)
        instance = new
        instance.instance_variable_set :@payload, EDA.serialize(payload).with_indifferent_access.freeze
        instance
      end
    end

    def initialize(data = {}, producer: EDA.service_name, version: self.class.version)
      @data = data
      @producer = producer
      @version = version
    end

    # @return [String]
    def topic = self.class.instance_variable_get(:@topic)

    # @return [UUID]
    def id = payload["event_id"]

    # @return [String]
    def name = payload["event_name"]

    # @return [Integer]
    def version = payload["event_version"]

    # @return [Hash]
    def data = payload["data"]

    # @return [Hash]
    def payload
      @payload ||= EDA.serialize(
        event_id: SecureRandom.uuid,
        event_name: self.class.name.gsub(/::V\d+/, ""),
        event_time: Time.current.to_s,
        event_version: @version,
        producer: @producer,
        data: @data.as_json
      ).with_indifferent_access.freeze
    end

    def valid?
      @errors ||= EDA.validate(self)
      @errors.empty?
    end

    def transactional?
      self.class.transactional?
    end
  end
end
