# frozen_string_literal: true

##
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': ENV.fetch('KAFKA_HOST', '127.0.0.1:9092'),
      'request.required.acks': 1
    }
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  Karafka.producer.monitor.subscribe(WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger, log_messages: true))

  routes.draw do
    consumer_group Rails.application.class.name.deconstantize.downcase do
      topic(:users_data_stream) { consumer ApplicationConsumer }
      topic(:users_registrations) { consumer ApplicationConsumer }
      topic(:users_permissions) { consumer ApplicationConsumer }

      topic(:tasks_data_stream) { consumer ApplicationConsumer }
      topic(:tasks_workflow) { consumer ApplicationConsumer }
    end
  end
end
