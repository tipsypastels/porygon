# A utility module that creates the bot startup messages.
module Startup
  class << self
    def log(key)
      unless ENV['SKIP_BOT']
        message = t(key)
        puts "#{t(:check)} #{message[:text]}".colorize(message[:color].to_sym)
      end

      yield
    end

    def t(key)
      I18n.t("porygon.internals.startup.#{key}")
    end
  end
end