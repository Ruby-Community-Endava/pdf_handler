# frozen_string_literal: true

module PdfHandler
  # PdfHandler::Utils
  module Utils
    private

    def path_with_date(path)
      splitted_path = path.split('.')
      (splitted_path[0...-1] + ["#{Time.now.to_i}.#{splitted_path.last}"]).join('-')
    end

    def find_binary_path(exe_name)
      possible_locations = (ENV['PATH'].split(':') + %w[/usr/bin /usr/local/bin ~/bin]).uniq
      exe_path ||= possible_locations.map do |l|
                     File.expand_path("#{l}/#{exe_name}")
                   end.find { |location| File.exist? location } # rubocop:disable Style/MultilineBlockChain
      exe_path || ''
    end
  end
end
