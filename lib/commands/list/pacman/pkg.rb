module Commands
  # Command that prints information about a package.
  class Pkg < Command
    self.tags = %w[pkg package packageinfo]
    self.args = Arguments::Parser.new do |a|
      a.arg :package, Resolvers.package
    end

    def call
      embed do |e|
        e.color = Porygon::COLORS.info
        e.title = "#{args.package.name} Package (#{args.package.tag})"
        e.description = args.package.description

        e.field('Exclusive', exclusiveness_text)
        e.field('Enabled channels', enabled_text)
      end
    end

    private

    def enabled_text
      # return 'None' unless args.enabled?(server)
      'TODO'
    end

    def exclusiveness_text
      return unless args.package.server_specific?

      text = 'To this server'
      servers_count = args.package.server_ids.count

      text += " and #{servers_count - 1} others" if servers_count > 1
      text
    end
  end
end