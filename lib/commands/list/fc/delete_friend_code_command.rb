module Commands
  class DeleteFriendCodeCommand < Command
    register 'delfc'

    args do |a|
      a.arg :console, FriendCode::DeleteConsole
    end

    def call(console:)
      if console.delete
        embed_success
      else
        embed_no_op(console)
      end
    end

    private

    def embed_success
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('deleted.title')
        e.desc  = t('deleted.desc')
      end
    end

    def embed_no_op(console)
      embed do |e|
        e.color = Porygon::COLORS.warning
        e.title = t("no_op.title.#{console.all? ? :all : :no_all}")
        e.desc  = t('no_op.desc')
      end
    end
  end
end