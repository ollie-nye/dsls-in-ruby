# frozen_string_literal: true

require 'date'

class SendPing < Operation
  requires :employee, :message, :link

  def call
    build_body
    send_ping
  end

  private

  def build_body
    @context[:body] = {
      message:,
      link:,
      end_date: DateTime.new(2023, 4, 25, 9, 0, 0)
    }
  end

  def send_ping
    # send ping
  end
end
