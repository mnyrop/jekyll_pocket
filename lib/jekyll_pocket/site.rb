require 'html-proofer'
require 'jekyll'

module JekyllPocket
  #
  #
  class Site
    def initialize(conf = nil)
      @config = self.config(conf)
      @root   = self.unique_root
    end

    #
    #
    def reconfigure
      Jekyll::Hooks.register :site, :after_init do |hook|
        hook.config['baseurl']    = @root
        hook.config['permalink']  = 'none'
      end
    end

    #
    #
    def rewrite(hook)
      JekyllPocket::Site.files(hook).each do |file|
        content = File.read(file)
        prefix  = JekyllPocket::Utils.depth_prefix(hook.dest, file)

        JekyllPocket::Utils.matches(content, @root).each do |match|
          result    = match.gsub(%r{/#{@root}/}, prefix).gsub(/["']/, '')
          resolved  = JekyllPocket::Utils.resolve(result, file)

          content.gsub!(match, resolved)
        end

        File.write(file, content)
      end

      JekyllPocket::Check.links(hook.dest)
    end

    #
    #
    def self.files(site)
      Dir.glob("#{site.dest}/**/*").select { |f| File.file?(f) }
    end

    #
    #
    def unique_root
      @config&.dig('jekyll_pocket', 'unique_root') || JekyllPocket::DEFAULT_ROOT
    end

    #
    #
    def config(conf)
      if conf.is_a? Hash
        conf
      elsif File.exist? JekyllPocket::DEFAULT_CONFIG
        YAML.safe_load(File.read(JekyllPocket::DEFAULT_CONFIG))
      else
        raise StandardError, 'JekyllPocket::Error ~> No valid config'.red
      end
    end
  end
end
