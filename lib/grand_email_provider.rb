require_relative 'grand_email_provider/sender'

module GrandEmailProvider
  def self.send_email(email:, subject:, message:)
    Sender.new(email, subject, message).send_email
  end
end
