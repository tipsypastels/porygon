class CreateRoleService
  extend Porygon::Util::HashAttributes
  
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
    
    set_bits
    make_requestable
    give_to_author
    self
  end

  private

  def set_bits
    role.packed = server.everyone_role.permissions.bits
  end

  def make_requestable
    role.requestable = true if requestable
  end

  def give_to_author
    author.add_role(role) if giveme
  end
end