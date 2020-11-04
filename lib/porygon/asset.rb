module Porygon
  class Asset
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def path
      @path ||= "assets/#{name}"
    end

    def attachment_path
      @attachment_path ||= "attachment://#{file_name}"
    end

    def file_name
      name.split('/').last
    end

    def file
      File.open(path, 'r')
    end
  end
end