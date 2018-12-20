module JekyllPocket
  #
  #
  module Check
    #
    #
    def self.links(dir)
      opts = { checks_to_ignore: %w[ImageCheck ScriptCheck] }
      runner = JekyllPocket.quiet_stdout do
        r = HTMLProofer.check_directory(dir, opts)
        r.check_files
        r
      end

      process_externals(runner.external_urls)
      process_failures(runner.process_files)
    end

    #
    #
    def self.process_failures(files)
      failures = files.map { |i| i[:failures] }.flatten
      return if failures.empty?

      warn "\nJekyllPocket::Error ~> The following broken links were detected:".red
      failures.each do |failure|
        warn "- link: '#{failure.content}'\n  in file: '#{failure.path.gsub(`pwd`.strip, '')}'\n  problem: '#{failure.desc}'"
      end
    end

    def self.process_externals(externals)
      return if externals.empty?
      warn "\nJekyllPocket::Warning ~> The following external links will not work offline:".yellow
      externals.each do |link, file|
        warn "- link: '#{link}'\n  in file: '#{file.first.gsub(`pwd`.strip, '')}'"
      end
    end
  end
end
