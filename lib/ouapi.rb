require 'net/http'
require 'net/smtp'
require 'json'
require 'csv'
require 'io/console'
require 'zip'
require 'rspec'
require 'cgi'

$:.unshift File.dirname(__FILE__)
module OUApi

  def self.gem_root
     File.expand_path File.dirname(__FILE__).chomp("/lib")
  end

  def self.test_files
    "#{OUApi.gem_root}/dev/sample"
  end

  def self.sandbox_root
  	"#{OUApi.gem_root}/data/sandbox"
  end

  def self.spec_root
    "#{self.gem_root}/spec"
  end
end

require 'ouapi/helpers'
require 'ouapi/user_apis'
require 'ouapi/superadmin_apis'
require 'ouapi/user'
require 'ouapi/superadmin'
require 'ouapi/sandbox'
Dir["#{File.dirname(__FILE__)}/ouapi/**/*.rb"].each {|file| require file }