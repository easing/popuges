# frozen_string_literal: true

##
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': ENV['KAFKA_HOST'],
      'security.protocol': 'SSL',
      'ssl.key.pem': File.read(Rails.root.join "ssl/user-access-key.key"),
      'ssl.certificate.pem': File.read(Rails.root.join "ssl/user-access-certificate.crt"),
      'ssl.ca.pem': File.read(Rails.root.join "ssl/ca-certificate.crt")
    }
    config.client_id = Rails.application.class.name.deconstantize.downcase.to_s
    config.consumer_persistence = !Rails.env.development?
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  Karafka.producer.monitor.subscribe(WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger, log_messages: true))

  routes.draw do
    consumer_group :tasks do
      topic(:users_data_stream) { consumer ApplicationConsumer }
      topic(:users_registrations) { consumer ApplicationConsumer }
      topic(:users_permissions) { consumer ApplicationConsumer }
    end
  end
end
