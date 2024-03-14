# frozen_string_literal: true

module EDA
  ##
  class Consumer
    cattr_accessor :versions

    attr_reader :event

    class << self
      def version(number, &block)
        @versions ||= {}
        @versions[number] = block
      end
    end

    def initialize(event)
      @event = event
    end

    delegate :data, to: :event

    def call
      versions = self.class.instance_variable_get(:@versions)

      version_consumer = versions[event.version]
      return if version_consumer.blank?

      instance_eval(&version_consumer)
    end
  end
end
