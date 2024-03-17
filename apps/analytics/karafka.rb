# frozen_string_literal: true

##
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': ENV.fetch('KAFKA_HOST', '127.0.0.1:9092')
    }

    if ENV["KAFKA_SSL"] == "true"
      config.kafka.merge!(
        'security.protocol': 'SSL',
        'ssl.key.pem': File.read(Rails.root.join "ssl/user-access-key.key"),
        'ssl.certificate.pem': File.read(Rails.root.join "ssl/user-access-certificate.crt"),
        'ssl.ca.pem': File.read(Rails.root.join "ssl/ca-certificate.crt")
      )
    end

    config.client_id = Rails.application.class.name.deconstantize.downcase.to_s
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  Karafka.producer.monitor.subscribe(WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger, log_messages: true))

  routes.draw do
    consumer_group Rails.application.class.name.deconstantize.downcase do
      topic(:users_data_stream) { consumer ApplicationConsumer }
      topic(:users_registrations) { consumer ApplicationConsumer }
      topic(:users_permissions) { consumer ApplicationConsumer }

      topic(:tasks_workflow) { consumer ApplicationConsumer }
      topic(:tasks_data_stream) { consumer ApplicationConsumer }

      topic(:balance_changes) { consumer ApplicationConsumer }
    end
  end
end
