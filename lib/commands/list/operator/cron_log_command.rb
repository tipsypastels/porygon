module Commands
  class CronLogCommand < Command
    register 'cronlog', permissions: { owner: true }

    
    def call
      embed do |e|
        e.color = Porygon::COLORS.ok
        e.title = t('title')
        e.desc  = file? ? code_block(file_slice) : t('empty')
      end
    end
      
    private
    
    FILE  = './cron_log.log'
    SLICE = 1000
    
    def file_slice
      file_lines.inject('') do |buffer, line|
        break buffer if buffer.size > SLICE
        "#{line}\n#{buffer}"
      end
    end

    def file_lines
      file.split("\n").reverse
    end

    def file
      @file ||= File.read(FILE) if File.exist?(FILE)
    end

    def file?
      file.present?
    end
  end
end