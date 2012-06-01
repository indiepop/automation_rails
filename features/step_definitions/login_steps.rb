Given /^Open '(.+)' page using (\w+) credential$/ do |site,credentials|
  Given "opened '#{site}' page using credential:", table(%{
    | User     | #{$info[credentials]['form_email']}     |
    | Password | #{$info[credentials]['form_password']} |
  })
end

Given /^opened '(.+)' page using credential:/ do |site,credentials|
  # open the browser if it's not exist
  unless $browser
    Initialization.start
  end
  credentials.rows_hash.each do |key,value|
    And "I type '#{value}' in '#{key}' field"
  end
#  When "I click 'Login' button"
#  Then "'Welcome' screen should be displayed"
#  Given "opened '#{screen}' screen"
end

