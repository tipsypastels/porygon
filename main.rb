require './pre_startup'

Startup.log :load_gems do
  require 'dotenv/load'
  require 'active_support/all'
  require 'action_view/helpers'
  require 'marky_markov'
  require 'discordrb'
  require 'fast_blank'
  require 'shellwords'
  require 'zeitwerk'
  require 'byebug'
  require 'sequel'
  require 'ostruct'
  require 'dentaku'
  require 'rack'
  require 'thin'
  require 'pg'
end

Startup.log :configure_gems do
  Dentaku.enable_ast_cache!
  I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
end

Startup.log :load_application do
  require_relative 'inflector'

  Loader = Zeitwerk::Loader.new
  Loader.inflector = Inflector.new

  Loader.push_dir(__dir__ + '/lib')
  Loader.collapse(__dir__ + '/lib/commands/list')
  Loader.collapse(__dir__ + '/lib/commands/list/*')
  Loader.collapse(__dir__ + '/lib/models')
  Loader.collapse(__dir__ + '/lib/core_ext')
  Loader.collapse(__dir__ + '/lib/services')
  Loader.preload(__dir__ + '/lib/database.rb')
  Loader.preload(__dir__ + '/lib/core_ext')
  Loader.preload(__dir__ + '/lib/discordrb')
  Loader.setup
  Loader.eager_load
end

Startup.log :create_bot do
  Bot = Porygon.spawn_bot
end

Startup.log :start_bot do
  Bot.start
end

Admin.start