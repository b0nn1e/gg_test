module Customers
  class Creator < ApplicationService
    attr_accessor :email

    validates :email, presence: true, email: true

    def initialize(args)
      super
      self.email = args[:email].strip
    end

    def call
      customer = Customer.find_or_create_by(email: email)
      if customer.valid?
        customer.save
        self.response = customer
      else
        add_errors(customer.errors)
      end
    end
  end
end
