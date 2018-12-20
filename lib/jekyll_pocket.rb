require 'jekyll'
require 'yaml'

require_relative 'jekyll_pocket/check'
require_relative 'jekyll_pocket/utils'
require_relative 'jekyll_pocket/site'

#
#
module JekyllPocket
  QUIET           = !ENV['DEBUG']
  RUN_POCKET      = !!(ENV['JEKYLL_ENV'] == 'pocket').freeze
  DEFAULT_ROOT    = '~~&&~~JEKYLL~~&&~POCKET~&&~~ROOT~~&&~~'.freeze
  DEFAULT_CONFIG  = './_config.yml'.freeze

  #
  #
  def self.quiet_stdout
    if QUIET
      begin
        orig_stderr = $stderr.clone
        orig_stdout = $stdout.clone
        $stderr.reopen File.new('/dev/null', 'w')
        $stdout.reopen File.new('/dev/null', 'w')
        retval = yield
      rescue StandardError => e
        $stdout.reopen orig_stdout
        $stderr.reopen orig_stderr
        raise e
      ensure
        $stdout.reopen orig_stdout
        $stderr.reopen orig_stderr
      end
      retval
    else
      yield
    end
  end

  if RUN_POCKET
    site = JekyllPocket::Site.new
    site.reconfigure
    Jekyll::Hooks.register :site, :post_write do |hook|
      site.rewrite(hook)
      puts "\nJekyllPocket::Success ~> Your pocket site was written to '#{hook.dest.gsub(`pwd`.strip, '')}'".cyan
    end
  end
end
