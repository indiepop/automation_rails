require "core/Initialization"

Given /^I Open main page using (#{USING_CREDENTIAL})$/ do  |table|

  unless $browser
    Initialization.start
  end                                                                    #initial browser


#  $browser.each do |browser|
#  end
      table.rows_hash.each do |key,value|
      steps %{And I type '#{value}' in '#{key}' field}
      #And  /^I type '#{value}' in '#{key}' field$/
      #  "I type '#{value}' in '#{key}' field"                                #TODO   :fix the  warning
      end

  $browser.find_element(:xpath => "//input[@class='bn-submit']").click     #set the username and password

end



