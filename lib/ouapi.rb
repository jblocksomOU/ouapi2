require 'net/http'
require 'net/smtp'
require 'json'
require 'csv'
require 'io/console'
require 'zip'
require 'rspec'

$:.unshift File.dirname(__FILE__)
begin
  require 'config'
rescue Exception => e 
    puts e.message
    puts "You need a config.rb. "
end

module OUApi

  def self.gem_root
     File.expand_path File.dirname(__FILE__).gsub("/lib","")
  end

  def self.test_files_root
    "#{OUApi.gem_root}/data/test_files"
  end

  def self.sandbox_root
  	"#{OUApi.gem_root}/data/sandbox"
  end
end

require 'ouapi/helpers'
require 'ouapi/user'
require 'ouapi/superadmin'
Dir["#{File.dirname(__FILE__)}/ouapi/**/*.rb"].each {|file| require file }