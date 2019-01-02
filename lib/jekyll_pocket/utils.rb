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
      parens_matches = content.scan(/[(].?#{root}[^)]*[)]/)
      [single_quoted_matches, double_quoted_matches, parens_matches].flatten
    rescue StandardError
      []
    end

    #
    #
    def self.clean(content, root)
      content.gsub(root, '')
    rescue StandardError
      content
    end

    #
    #
    def self.result(match, root, prefix)
      result = match.gsub(root, prefix)
      result.gsub!(/["'()]/, '')
      result.gsub!(%r{/+}, '/')
      result.gsub!(%r{\A/}, '')
      resolve(result)
    end

    #
    #
    def self.resolve(result)
      return result unless File.extname(result).empty?

      if result.empty? || result.end_with?('/')
        "#{result}index.html"
      else
        "#{result}.html"
      end
    end
  end
end
