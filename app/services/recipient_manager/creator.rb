module RecipientManager
  class Creator < ApplicationService
    attr_accessor :email

    validates :email, presence: true, email: true

    def initialize(args)
      super
      self.email = args[:email].strip
    end

    def call
      recipient = Recipient.find_or_create_by(email: email)
      if recipient.valid?
        recipient.save
        self.response = recipient
      else
        add_errors(recipient.errors)
      end
    end
  end
end
