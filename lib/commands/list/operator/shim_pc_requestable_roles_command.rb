module Commands
  # rubocop:disable all
  class ShimPcRequestableRolesCommand < Command
    register '%shim_pcrequestableroles', permissions: { owner: true }

    def call
      @found, @skipped = 0, 0

      ROLES.each do |role_name|
        role = find_role(role_name)
        role.requestable = true if role
      end

      say "Done. #{@found} roles made requestable, #{@skipped} skipped (missing)."
    end

    private

    def find_role(name)
      role = Discordrb::Role.from_argument(method(:log_missing), name, self)

      if role
        Porygon::LOGGER.info("#{name} is now requestable.")
        @found += 1
        role
      end
    end

    def log_missing(_, interps)
      @skipped += 1
      Porygon::LOGGER.warn("#{interps[:arg]} could not be found, skipping!")
    end

    ROLES = [
      'he / him',
      'she / her',
      'they / them',
      'no corona',
      'no politics',
      'Art Feedback',
      'Writing Feedback',
      'Music Fans',
      'Voice Chatter',
      'Twerps',
      'Battlers',
      'Raiders',
      'PoGo Raiders',
      'Shiny Hunters',
      'Events',
      'Villagers',
      'Prosecuties',
      'Warriors of Light',
      'Impostor',
      'Jackbox',
      'darkred',
      'staffadmin red',
      'bleh red',
      'bad alola hat',
      'tired maroon',
      'eternally red',
      'lysandred',
      'orangensaft',
      'magikarp orange',
      'sun orange',
      'smod orange',
      'pumpking',
      'tea with milk',
      'BEES',
      'snorunt orange',
      'mariGOLD',
      'very sexy pink',
      'lemongrab',
      'jumpsuit jumpsuit',
      'ambergris',
      'mossdog',
      'prince green',
      'bad rad',
      'Bulb Green',
      'touched',
      'radioactive green',
      'GREENER',
      'green eggs no ham',
      'neat trainer',
      'AA green',
      'pink salmon',
      'hold the door',
      'toothpaste',
      'frogwaifu',
      'shinymence',
      'bright teal',
      'Odd Blue Colour',
      'teal',
      'something',
      'ultimate detective',
      'chillyboi',
      'platinum blue',
      'trash taste in food',
      "well it's kinda pink",
      'pale orange',
      'not blue',
      'Greninavy',
      'the only gen 3 fanboy',
      'brotherhood of steel blue',
      'sky high',
      'dark blu',
      'BLURPLE FOREVER',
      'god of mischief',
      'shiny spheal purple',
      'poptart',
      'liar',
      'Lavender Soap',
      'grape jelly lollipop',
      'Goo-Goo Dolls',
      'cobalt...purple?',
      "spyro's bubble bath",
      'fancy purple',
      'wingardium leviosa',
      'off the chain',
      'goth purple',
      'slate gray',
      'maroon',
      "white but it's actually pink",
      'light pink',
      'pinkish',
      'pale sky',
      'mid pink',
      'Perplexed Pink',
      'fairly pink',
      'NOT hotpink color',
      'pink af',
      'purplishpink',
      'dark green',
      'super pink af',
      'slurpuff pink',
      'Buying clothes at the soup store',
      'de-pinked',
      'Nebula',
      'marshmallow gold',
      'wookie fur',
      'cafe',
      'SCREAMING',
      '50 shades of',
    ]
  end
  # rubocop:enable all
end