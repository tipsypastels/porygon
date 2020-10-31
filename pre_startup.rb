if __FILE__ == $PROGRAM_NAME
  puts "Don't run pre_startup manually, run main instead."
  exit
end

require 'i18n'
require 'colorize'
require './lib/startup'
I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']