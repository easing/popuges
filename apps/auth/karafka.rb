# frozen_string_literal: true

##
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': ENV['KAFKA_ADVERTISED_HOST_NAME'] }
    config.client_id = Rails.application.class.name.deconstantize.downcase.to_s
    config.consumer_persistence = !Rails.env.development?
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  Karafka.producer.monitor.subscribe(WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger, log_messages: true))

  routes.draw do

  end
end

Karafka::Web.setup do |config|
  # You may want to set it per ENV. This value was randomly generated.
  config.ui.sessions.secret = 'a0f690f15d44fcc2bc2e1d48ed63aa13d8a95c4c951ee0c350854121e2e6c45e'
end

Karafka::Web.enable!

