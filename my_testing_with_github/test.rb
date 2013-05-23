require "rubygems"
require "selenium-webdriver"

driver = Selenium::WebDriver.for :remote, :url => "http://10.30.178.48:4444/wd/hub" ,:desired_capabilities => :chrome
driver.get "http://www.google.com"
#driver.save_screenshot "/Screenshots/google.png"

#http://docs.seleniumhq.org/download/
#java -jar selenium-server-standalone.jar
#http://selenium.googlecode.com/files/selenium-server-standalone-2.33.0.jar
