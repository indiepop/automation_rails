require "rubygems"
require "selenium-webdriver"



#System.setProperty("webdriver.firefox.bin","D:\Program Files (x86)\Mozilla Firefox\firefox.exe");
#driver = Selenium::WebDriver.for :remote, :url => "http://localhost:4444/wd/hub" ,:desired_capabilities => :firefox
#driver.get "http://www.google.com"
#driver.save_screenshot "/Screenshots/google.png"

#http://docs.seleniumhq.org/download/
#java -jar selenium-server-standalone.jar
#http://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar


=begin

require 'snmp'

ifTable_columns = ["ifIndex", "ifDescr", "ifInOctets", "ifOutOctets"]
SNMP::Manager.open(:host => '10.30.155.76') do |manager|
  manager.walk(ifTable_columns) do |row|
    row.each { |vb| print "\t#{vb.value}" }
    puts
  end
end

t1=Time.mktime(2013,7,18,13,4,20)
t2=Time.mktime(2013,7,21,9,56,28)
puts (t2 - t1)/60/60



puts '-'*80
=end
# encoding: utf-8

=begin
driver = Selenium::WebDriver.for :ff
driver.get "http://www.douban.com/group"

e = driver.find_element(:xpath,"//*[contains(.,'douban.com')][count(ancestor-or-self::*[not(contains(@style,'display: none')) and not(contains(@style,'visibility: hidden'))])=count(ancestor-or-self::*)]")
puts e
=end
#driver.quit


browser = Selenium::WebDriver.for :remote,:url=>"http://10.30.178.48:4444/wd/hub",:desired_capabilities => :firefox
browser.get "http://www.baidu.com"