module Commands
  class ByebugCommand < Command
    register 'byebug', permissions: { owner: true }, context: :any

    def call
      byebug
    end
  end
end