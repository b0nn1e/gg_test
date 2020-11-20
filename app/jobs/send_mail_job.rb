require 'grand_email_provider'

class SendMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GrandEmailProvider.send_email(*args)
  end
end
