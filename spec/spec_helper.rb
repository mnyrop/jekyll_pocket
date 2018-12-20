require 'jekyll_pocket'
require 'html-proofer'
require_relative 'setup'

context JekyllPocket do
  before(:all) do
    JekyllPocket.reset_tests
  end
  describe 'jekyll build' do
    it 'runs without errors' do
      expect {
        puts `JEKYLL_ENV='pocket' bundle exec jekyll build --quiet`
      }.not_to raise_error
    end
  end
end
