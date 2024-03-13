module EDA
  class Consumer
    cattr_accessor :versions
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def data
      event.data
    end

    def call
      versions = self.class.instance_variable_get(:@versions)
      instance_eval &versions[event.version]
    end

    def self.version(number, &block)
      @versions ||= {}
      @versions[number] = block
    end
  end
end
