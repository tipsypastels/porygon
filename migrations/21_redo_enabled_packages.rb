Sequel.migration do
  change do
    drop_table :enabled_packages

    create_table :enabled_packages do
      primary_key :id

      Bignum :server_id, null: false
      String :tag, null: false

      # this is NOT 1nf - we're storing multiple values
      # in one column. however, I think it's fine in this
      # case for two reasons:
      #
      #   1. The most common case is for a package
      #   to be enabled in all channels, represented
      #   as null in this case. By contrast, making an
      #   entry for every channel on a server is a 
      #   waste of space and doesn't even work in the
      #   case of channels created later.
      #
      #   2. Enabled packages are fetched and cached
      #   in memory the first time anyone uses any
      #   command, and only get refreshed when someone
      #   changes one of their settings. This means that
      #   we don't have to deal with the complexity
      #   of parsing them to channel IDs over and over.
      String :channels, text: true, null: true

      index %i[server_id tag], unique: true
    end
  end
end