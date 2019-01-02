require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end

require 'jekyll_pocket'
require 'html-proofer'
require_relative 'setup'

context JekyllPocket do
  before(:all) do
    JekyllPocket.reset_tests
  end
  describe 'jekyll pocket' do
    it 'runs without errors' do
      # expect { `bundle exec jekyll pocket` }.not_to raise_error
    end
  end
end
