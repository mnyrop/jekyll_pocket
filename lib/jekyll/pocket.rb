module Jekyll
  # Main module with helpers
  module Pocket
    DEFAULT_UNIQUE_ROOT = '~~&&~~JEKYLL~~&&~POCKET~&&~~ROOT~~&&~~'.freeze

    #
    #
    def self.reconfig(root)
      Jekyll::Hooks.register :site, :after_init do |site|
        site.config['baseurl']    = root
        site.config['permalink']  = 'none'
      end
    end

    #
    #
    def self.rewrite(root)
      Jekyll::Hooks.register :site, :post_write do |site|
        Jekyll::Pocket.files(site).each do |file|
          content = File.read(file)
          prefix  = Jekyll::Pocket.depth_prefix(site.dest, file)

          Jekyll::Pocket.matches(content, root).each do |match|
            result    = match.gsub(%r{/#{root}/}, prefix).gsub(/["']/, '')
            resolved  = Jekyll::Pocket.resolve(result, file)

            content.gsub!(match, resolved)
          end

          File.write(file, content)
        end
      end
    end

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
    def self.files(site)
      Dir.glob("#{site.dest}/**/*").select { |f| File.file?(f) }
    end

    #
    #
    def self.matches(content, root)
      single_quoted_matches = content.scan(/['].?#{root}[^']*[']/)
      double_quoted_matches = content.scan(/["].?#{root}[^"]*["]/)
      single_quoted_matches.concat double_quoted_matches
    end

    def self.resolve(result, file)
      if File.extname(result).empty?
        if result.empty? || result.end_with?('/')
          result += 'index.html'
        else
          warn "Jekyll::Pocket::Warning\nThe link '#{result}' in file '#{file.gsub(`pwd`.strip, '')}' is missing an extension.\nAttempting to resolve...\n".yellow
          result += '.html'
        end
      end
      result
    end

    #
    #
    def self.unique_root(config = nil)
      default_file = './_config.yml'
      config = if config.is_a? Hash
                 config
               elsif File.exist? default_file
                 YAML.safe_load(File.read(default_file))
               end

      config&.dig('jekyll_pocket', 'unique_root') || DEFAULT_UNIQUE_ROOT
    end
  end
end
