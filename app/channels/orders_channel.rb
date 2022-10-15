class OrdersChannel < ApplicationCable::Channel
  STREAM_NAME = 'orders:notifications'

  def subscribed
    stream_for STREAM_NAME
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.broadcast(message)
    broadcast_to(STREAM_NAME, message)
  end
end
