QUIET = !ENV['DEBUG']

require 'jekyll-pocket'
require 'html-proofer'
require_relative 'setup'

context Jekyll::Pocket do
  before(:all) do
    Jekyll::Pocket::reset_tests
  end
  describe 'jekyll build' do
    it 'runs' do
      expect {
        quiet_stdout{
          puts `JEKYLL_ENV='pocket' bundle exec jekyll build`
        }
      }.not_to raise_error
    end
    it 'has no broken links' do
      options = { check_html: false, disable_external: true, verbose: true }
      expect {
        quiet_stdout {
          HTMLProofer.check_directory('./_site', options).run
        }
      }.not_to raise_error
    end
  end
end
