RSpec.describe Arguments::Parser do
  R = ::Resolvers

  UsageError   = Commands::UsageError
  StaticError  = Commands::StaticError
  ResolveError = Commands::ResolveError

  def create_args(&block)
    Arguments::Parser.new(&block)
  end

  context 'basic parsing' do
    describe 'strings' do
      it 'parses strings' do
        args = create_args { _1.arg :hello, R::StringResolver }
        expect(args.to_h('hello')).to eq(hello: 'hello')
      end
    end

    describe 'ints' do
      it 'parses positive ints' do
        args = create_args { _1.arg :num, R::IntResolver }
        expect(args.to_h('1')).to eq(num: 1)
      end

      it 'parses negative ints' do
        args = create_args { _1.arg :num, R::IntResolver }
        expect(args.to_h('-1')).to eq(num: -1)
      end

      describe 'with a range' do
        it 'stays within the range' do
          args = create_args { _1.arg :num, R::IntResolver[1..] }
          expect(args.to_h('1')).to eq(num: 1)
        end

        it 'violates the range' do
          args = create_args { _1.arg :num, R::IntResolver[1..] }
          expect { args.to_h('0') }.to raise_error(ResolveError)
        end
      end
    end
  end

  context 'multiple arguments' do
    describe 'multiple arguments of different types' do
      it 'works with string first' do
        args = create_args do |a|
          a.arg :str, R::StringResolver
          a.arg :int, R::IntResolver
        end

        expect(args.to_h('a 1')).to eq(int: 1, str: 'a')
      end
      
      it 'works with string last' do
        args = create_args do |a|
          a.arg :int, R::IntResolver
          a.arg :str, R::StringResolver
        end

        expect(args.to_h('1 a')).to eq(int: 1, str: 'a')
      end
    end
  end
end