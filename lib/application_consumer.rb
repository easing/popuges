# frozen_string_literal: true

##
class ApplicationConsumer < Karafka::BaseConsumer
  def consume
    messages.each { |message| EDA.consume(message.payload) }
  end
end
