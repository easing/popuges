# frozen_string_literal: true

##
class ApplicationConsumer < Karafka::BaseConsumer
  def consume
    messages.each &::Handler.method(:run)
  end
end
