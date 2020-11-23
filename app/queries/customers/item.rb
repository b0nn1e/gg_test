module Customers
  class Item < ApplicationQuery
    attr_accessor :id

    def initialize(args)
      super
      self.id = args[:id].to_i
    end

    def call
      Customer.find(id)
    end
  end
end
