class CreateRoleService
  extend Porygon::HashAttributes
  
  attr_reader :role, :server, :author, :moved
  hash_attr_reader :name, :color, :hoist, :giveme,
                   :requestable, :mentionable, on: :@args

  delegate :hex, to: :color, allow_nil: true
  delegate :mention, to: :role

  def initialize(server, author, args)
    @server = server
    @author = author
    @args   = args
  end

  def create
    @role = server.create_role name: name, 
                                colour: color,
                                hoist: hoist,
                                mentionable: mentionable
    
    make_requestable
    give_to_author
    self
  end

  private

  def make_requestable
    # TODO: make requestable roles
  end

  def give_to_author
    author.add_role(role) if giveme
  end
end