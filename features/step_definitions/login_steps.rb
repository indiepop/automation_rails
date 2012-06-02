require "douban_core/Initialization"

Given /^I Open main page using (#{USING_CREDENTIAL})$/ do  |table|

  unless $browser
    Initialization.start
  end

  login = $browser.is_element_present(logout='//div[@class="top-nav-info"]/a[3]')
  if login
    $browser.find_element(:xpath,logout).click
  end

  table.rows_hash.each do |key,value|
    step "I type '#{value}' in '#{key}' field"
  end


end



