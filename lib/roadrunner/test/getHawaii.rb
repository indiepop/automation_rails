
$:.unshift File.expand_path( File.join(File.dirname(__FILE__),'..','lib'))
require 'roadrunner'
require 'httparty'


getHawaii= RoadRunner.new


getHawaii.init do
  getHawaii.users,getHawaii.iterations=3,3
end

getHawaii.action do
    getHawaii.homepage do
      resp= HTTParty.get ("http://www.hawaii.com")
      resp.header.inspect.include? 'Apache'
    end
end

getHawaii.run

