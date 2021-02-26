Sequel.migration do
  change do
    create_table(:activity_messages) do
      primary_key :id
      String :message, null: false

      index :message, unique: true
    end

   ['cyberduck supreme',
'mining bitcoin',
'just vibing',
'drunk internet duck',
'Duck Game',
'downloading more ram',
'plotting against dakota',
'planning a coup',
'high on potenuse',
'hacking the mainframe',
'deleting the database',
'beep boop. error',
'how are you?',
'taking a nap',
'sleeping in class',
'in a duck pond',
'ducking around',
'calculating...',
'using math for evil',
'writing more statuses',
'press ctrl-c to quit',
'dumb',
'committing crimes',
'being gay, doing crimes',
'MCR — Black Parade',
'quacking in the matrix',
'porygone to the store',
'stanning inky',
'beating up geese',
'eatin quackers',
'doing hot bot shit',
'playing with firequackers',
'hey got any grapes',
'remaking the remakes',
'duck duck goose',
'daffy-duck',
'watching an*me',
'release the quacken!'].each do |message|
      from(:activity_messages).insert(message: message)
    end
  end
end