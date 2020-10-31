require './pre_startup'

Startup.log :load_gems do
  require 'dotenv/load'
  require 'active_support/all'
  require 'marky_markov'
  require 'discordrb'
  require 'zeitwerk'
  require 'fast_blank'
  require 'byebug'
  require 'sequel'
  require 'logger'
  require 'ostruct'
  require 'dentaku'
  require 'pg'
end

Startup.log :load_discordrb_ext do
  require './lib/discordrb/ext'
end

Startup.log :configure_gems do
  Discordrb::LOGGER.mode = :silent
  Dentaku.enable_ast_cache!
  I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
end

Startup.log :load_application do
  Loader = Zeitwerk::Loader.new
  Loader.push_dir(__dir__ + '/lib')
  Loader.do_not_eager_load(__dir__ + '/lib/discordrb')
  Loader.collapse(__dir__ + '/lib/commands/list')
  Loader.collapse(__dir__ + '/lib/commands/list/*')
  Loader.collapse(__dir__ + '/lib/packages/list')
  Loader.enable_reloading
  Loader.setup
  Loader.eager_load
end

Startup.log :register_commands do
  Commands.register_all
end

Startup.log :create_bot do
  Bot = Porygon.spawn_bot
end

Startup.log :start_bot do
  Bot.start
end