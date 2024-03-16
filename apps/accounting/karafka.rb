# frozen_string_literal: true

##
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': ENV['KAFKA_HOST'],
      'allow.auto.create.topics': true,
      'security.protocol': 'SASL_SCRAM'
    }
    config.client_id = Rails.application.class.name.deconstantize.downcase
    config.consumer_persistence = !Rails.env.development?
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

      topic(:system_clock) { consumer ApplicationConsumer }
    end
  end
end
