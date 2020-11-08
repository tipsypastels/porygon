module Commands
  class ByebugCommand < Command
    register 'byebug', permissions: { owner: true }

    def call
      byebug
    end
  end
end