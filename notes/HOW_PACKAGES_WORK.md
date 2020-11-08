# How Packages Work

Commands in Porygon are grouped into "packages", which are small groups of commands that share a similar use or purpose. For example, "games", "util", and "mod" are packages.

As a server operator, you use packages to define what commands you want to work in what channels. For example, you may want only "games" to work in "#random" or "#bot-spam" or the like. You can do so with the `enablePackage` command.

```
!enablePackage games --channels "random, bot-spam"
```

You can also enable a package in all channels using `--channels all`, however this is limited right now (see footnote 1).

### Disabling packages

Fairly self-explanatory, right! It's `!disablePackage`. The usage is exactly the same as the example above.

### Listing and inspecting packages

`!packageList` shows you a list of packages. `!package <name>` will show you information about a specific package.

## The `!commands` command

**Note:** Unlike the above examples, `!commands` is not a super-global (see super-globals below) and needs to be explicitly enabled by adding the `meta` package.

`!commands` is a command that lists commands. It will only show commands available to the user using it, so it never lists mod commands to regular users, for instance. It will also show which channel(s) a given command can be used in. Commands not usable in any channel are omitted (2).

## `!packageList` vs `!commands`

The two do similar things, but there are some superficial differences.

- `packageList` is a super-global and only available to server admins, while `commands` is not a global and can be used by anyone as long as the `meta` package is enabled.
- `packageList` doesn't do permission checks, as it assumes that if you're able to use it, you can pretty much use any other command too.
- `packageList` lists packages that are not enabled in any channel, `commands` does not.

## Super-global packages

There are currently two "super-global" packages (the name super-global comes from the fact that there were originally global packages as a separate concept but they ended up being scrapped). Super-global packages can never be enabled or disabled, and will always function to those with the permissions to use them. The current two are:

- `operator`, which contains debugging tools. It is only available to the bot's owner.
- `package`, which contains commands to enable and disable packages. It is only usable to administrators of a given server.

## Footnotes

**1 - Enabling packages in all channels**
This is supported, as mentioned above. However, there is currently no way to tell Porygon to automatically include the packages in any *new* channels created after the command is run. Support for this will be coming in the future.

**2 - Packages enabled only in hidden channels**
While Porygon will hide commands that the current user lacks permission to use from `!commands`, it does *not* currently hide commands that the user technically has permission to use, but which are only enabled in channels that the user cannot see. Thus, for example, having a `#staff` channel which has special commands enabled will work, but such commands (and the name of the hidden channel they are enabled in) will be visible to ordinary users via `!commands`. If this turns out to be a common use case, I'll add support for hiding them.