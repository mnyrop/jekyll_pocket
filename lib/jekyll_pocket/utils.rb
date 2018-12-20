module JekyllPocket
  #
  #
  module Utils
    #
    #
    def self.depth_prefix(dest, file)
      prefix  = ''
      pdest   = Pathname.new(dest)
      rpath   = Pathname.new(file).relative_path_from(pdest)
      depth   = rpath.to_s.count('/')
      depth.times { prefix.prepend('../') }
      prefix
    end

    #
    #
    def self.matches(content, root)
      single_quoted_matches = content.scan(/['].?#{root}[^']*[']/)
      double_quoted_matches = content.scan(/["].?#{root}[^"]*["]/)
      single_quoted_matches.concat double_quoted_matches
    end

    #
    #
    def self.resolve(result, file)
      if File.extname(result).empty?
        if result.empty? || result.end_with?('/')
          result += 'index.html'
        else
          warn 'JekyllPocket::Warning ~> Missing File Extension'.yellow
          warn "- link '#{result}'\n  in file: '#{file.gsub(`pwd`.strip, '')}'\n"
          warn "  Auto-resolving as #{result}.html.\n".cyan
          result += '.html'
        end
      end
      result
    end
  end
end
