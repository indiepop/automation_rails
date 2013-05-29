require "core/Initialization"

Given /^I Open main page using (#{USING_CREDENTIAL})$/ do  |table|

  unless $browser
    Initialization.start
  end                                                                    #initial browser

  login = $browser.is_element_present(logout='//div[@class="top-nav-info"]/a[3]')
  if login
    $browser.find_element(:xpath,logout).click
  end                                                                    #if already login, then click out.

  table.rows_hash.each do |key,value|
 # steps %{And I type '#{value}' in '#{key}' field}
  "I type '#{value}' in '#{key}' field"                                #TODO   :fix the  warning
  end                                                                    #set the username and password
    $browser.find_element(:xpath => "//input[@class='bn-submit']").click
end



