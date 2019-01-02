require 'jekyll'
require 'yaml'

require_relative 'jekyll_pocket/utils'
require_relative 'jekyll_pocket/check'
require_relative 'jekyll_pocket/hook'

#
#
module JekyllPocket
  DEFAULT_ROOT    = '~~~~!!JEKYLL~~~POCKET~~~ROOT!!~~~~'.freeze
  DEFAULT_CONFIG  = './_config.yml'.freeze

  #
  #
  class PocketCommand < Jekyll::Command
    class << self
      def init_with_program(prog)
        prog.command(:pocket) do |c|
          c.syntax 'pocket [options]'
          c.description 'Build your site'

          c.action do |_args, options|
            hook = JekyllPocket::Hook.new
            hook.reconfigure
            Jekyll::Hooks.register :site, :post_write do |s|
              hook.rewrite(s)
              puts "\nJekyllPocket::Success ~> Your pocket site was written to '#{s.dest.gsub(`pwd`.strip, '')}'".cyan
            end

            options = configuration_from_options(options)
            site = Jekyll::Site.new(options)
            site.process
          end
        end
      end
    end
  end
end
