class Arguments
  module MetaConverters
    # rubocop:disable Naming/MethodName
    def Array(type, split: /\s*,\s*/)
      Class.new do
        define_singleton_method :from_argument do |error, arg, command|
          arg.split(split).map { type.from_argument(error, _1, command) }
        end

        define_singleton_method :to_s do
          type.to_s.pluralize
        end
      end
    end
    # rubocop:enable Naming/MethodName
  end
end