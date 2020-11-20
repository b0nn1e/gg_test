class ApplicationQuery
  # TODO: Implement default pagination and etc
  attr_accessor :args

  def self.call(args = {})
    new(args).call
  end

  def initialize(args)
    self.args = args.with_indifferent_access
  end
end
