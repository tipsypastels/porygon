RSpec.describe Arguments::Parser do
  Resolvers    = Arguments::Resolvers
  UsageError   = Commands::UsageError
  ResolveError = Commands::ResolveError

  def create_args(&block)
    Arguments::Parser.new(&block)
  end

  context 'basic parsing' do
    describe 'strings' do
      it 'parses strings' do
        args = create_args { _1.arg :hello, Resolvers.string }
        expect(args.to_h('hello')).to eq(hello: 'hello')
      end
    end

    describe 'ints' do
      it 'parses positive ints' do
        args = create_args { _1.arg :num, Resolvers.int }
        expect(args.to_h('1')).to eq(num: 1)
      end

      it 'parses negative ints' do
        args = create_args { _1.arg :num, Resolvers.int }
        expect(args.to_h('-1')).to eq(num: -1)
      end

      describe 'with a range' do
        it 'stays within the range' do
          args = create_args { _1.arg :num, Resolvers.int(1..) }
          expect(args.to_h('1')).to eq(num: 1)
        end

        it 'violates the range' do
          args = create_args { _1.arg :num, Resolvers.int(1..) }
          expect { args.to_h('0') }.to raise_error(ResolveError)
        end
      end
    end
  end
end