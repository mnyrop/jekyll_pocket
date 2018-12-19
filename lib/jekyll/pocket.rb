module Jekyll
  module Pocket
    def self.depth_prefix(dest, file)
      prefix  = ''
      root    = Pathname.new(dest)
      rpath   = Pathname.new(file).relative_path_from(root)
      depth   = rpath.to_s.count('/')
      depth.times { prefix.prepend('../') }
      prefix
    end
  end
end
