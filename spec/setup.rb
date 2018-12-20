require 'fileutils'

ROOT    = `pwd`.strip.freeze
SAMPLE  = "#{ROOT}/spec/sample_site".freeze
BUILD   = "#{ROOT}/test_build".freeze

module JekyllPocket
  def self.reset_tests
    Dir.chdir(ROOT)
    FileUtils.rm_r(BUILD) if File.directory?(BUILD)
    FileUtils.copy_entry(SAMPLE, BUILD)
    Dir.chdir(BUILD)
  end
end
