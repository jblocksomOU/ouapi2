require 'net/http'
require 'json'
require 'csv'
require 'rspec'
require 'cgi'
require 'io/console'

$:.unshift File.dirname(__FILE__)
module OUApi

#--path to the root of the game----
  def self.gem_root
     File.expand_path File.dirname(__FILE__).chomp("/lib")
  end
#----------------------------------

#---path to the spec root----------
  def self.spec_root
    "#{self.gem_root}/spec"
  end
end
#----------------------------------

#-- The loading order is important. 
require 'ouapi/helpers'
require 'ouapi/user_apis'
require 'ouapi/superadmin_apis'
require 'ouapi/user'
require 'ouapi/superadmin'
require 'ouapi/sandbox'
Dir["#{File.dirname(__FILE__)}/ouapi/**/*.rb"].each {|file| require file }