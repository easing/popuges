# frozen_string_literal: true

##
class KarafkaApp < Karafka::App
  application_name = Rails.application.class.name.deconstantize.downcase.to_s

  setup do |config|
    config.kafka = { 'bootstrap.servers': ENV['KAFKA_ADVERTISED_HOST_NAME'] }
    config.client_id = application_name
    config.consumer_persistence = !Rails.env.development?
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  Karafka.producer.monitor.subscribe(WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger, log_messages: true))

  routes.draw do
    consumer_group application_name do
      topic(:auth) { consumer ApplicationConsumer }
      topic(:tasks) { consumer ApplicationConsumer }
    end
  end
end
