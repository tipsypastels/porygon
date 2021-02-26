module Porygon
  class ActivityMessage < Sequel::Model
    def self.sample
      order(Sequel.lit('RANDOM()')).limit(1).first&.message
    end

    def self.add(message)
      create message: message
    end
  end
end