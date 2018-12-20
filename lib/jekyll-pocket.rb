require 'jekyll'
require 'yaml'

require_relative 'jekyll/pocket'

if !!(ENV['JEKYLL_ENV'] == 'pocket')
  root = Jekyll::Pocket.unique_root

  Jekyll::Pocket.reconfig(root)
  Jekyll::Pocket.rewrite(root)
end
