Then /^'(.*)' (.+) should( not)? be displayed(?: in (\d+) seconds?)?( .+)?$/ do |object_name, object_type, shouldnot, second, scope|
  $browser.wait_for_body_text
  container_locator = $browser.get_container_locator_by_scope(scope)
  second ||= 5
  second = second.to_i
  aliases = {
      "screen" => Screen,
      "dialog" => Dialog,
      "popup" => Popup,
      "panel" => Panel,
      "extdialog"=>ExtDialog,
      "popupmenu" =>PopupMenu,
      "grid" =>GridWcfTable,
      "tree grid" => TreeWcfTable,
     # "chart" => WCF::Components::Chart,
      "link" => Link,
      "cylinder" => Cylinder,
      "icon" => Icon,
      "button" => Button,
      "message" => Text
  }

  raise "Unknown object type: #{object_type}." if aliases[object_type.to_s.downcase].nil?



  container_class = aliases[object_type.to_s.downcase]

  if container_class == Text
    WCF::Components::Object.new("//*[contains(.,'#{object_name}')]").is_present?          #This this the only way for Text
  else
    find_result = container_class.new(object_name,container_locator)
    if  find_result.is_present?
      begin
        find_result.wait(second).should == should_not.nil?
      rescue RSpec::Expectations::ExpectationNotMetError
        raise "#{object_type} with name '#{object_name}' expected#{should_not.nil? ? '' : ' not'} to be present but it doesn't."
      end
    else
    raise "Error! This '#{object_name}' #{object_type} isn't exist!"
    end
  end
end

# This step is to verify that some *screen* or *box* or *popup* or *border* is *disappear*
Then /^'(.*)' (.+) should be disappear(?: in (\d+) seconds?)?( .+)?$/ do |object_name, object_type, second, scope|
  $browser.wait_for_body_text
  container_locator = $browser.get_container_locator_by_scope(scope)
  second ||= 5
  second = second.to_i
  aliases = {
      "screen" => Screen,
      "dialog" => Dialog,
      "popup" => Popup,
      "panel" => Panel,
      "extdialog"=>ExtDialog,
      "popupmenu" => PopupMenu,
      "grid" => GridWcfTable,
      "tree grid" => TreeWcfTable,
      "chart" => Chart,
      "link" => Link,
      "cylinder" => Cylinder,
      "icon" => Icon,
      "button" => Button,
      "message" => Text
  }

  raise "Unknown object type: #{object_type}." if aliases[object_type.to_s.downcase].nil?

  container_class = aliases[object_type.to_s.downcase]
  $browser.wait_for_element_not_present(container_class.new(object_name, container_locator).get_locator, second)
end
# @note Possible containers is: grid, tree, collapsible tree, tree table, collapsible tree table.
# This step is to verify that *grid* or *tree* contains or not specified *rows* or *elements*.
#
# Table templates:
# For grids:
# | Column 1 header | Column 2 header | Column n header |
# | Row column 1 value | Row column 2 value | Row column n value |
# For trees:
# | Element 1 |
# | Element 2 -> element under Element 2 |
# | Element n |
# For tree tables:
# | Element 1 | |
# | Element 2 -> element under Element 2 | [img] |
# | Element n | [img]normal |
#Then /^'(.+)'( collapsible)? (grid|tree(?: table)?) should( not)? contain next (?:row|element)s?:$/ do |object_name, collapsible, object_type, shouldnot, table|
# case object_type
# when "grid"
# container = Grid.new(object_name)
# table.hashes.each do |row|
# begin
# row.delete_if { |key, value| value.empty? }
# container.include?(row).should == shouldnot.nil?
# rescue RSpec::Expectations::ExpectationNotMetError
# raise "Next row is#{shouldnot.nil? ? ' not' : ''} found:\n#{row.to_s}"
# end
# end
# when "tree"
# container = Collapsible.new(object_name).tree
# table.raw.each do |element|
# begin
# container.include?(element[0]).should == shouldnot.nil?
# rescue RSpec::Expectations::ExpectationNotMetError
# raise "#{object_name} #{object_type} is#{shouldnot.nil? ? ' not' : ''} contain #{element} element."
# end
# end
# when "tree table"
# unless collapsible.nil?
# container = Collapsible(object_name).tree_table
# else
# container = TreeWcfTable.new(object_name)
# end
# table.raw.each do |element, second_column|
# begin
# container.include?(element, second_column).should == shouldnot.nil?
# rescue RSpec::Expectations::ExpectationNotMetError
# raise "#{object_name} #{object_type} is#{shouldnot.nil? ? ' not' : ''} contain | #{element} |#{second_column.to_s == "" ? "" : " "+second_column+" |"} element."
# end
# end
# end
#end


#This step is to verify message area should or should not displayed
Then /^message area should( not)? be displayed$/ do |shouldnot|
  message_area ="//div[@class = 'messageArea']"
  begin
    message = Element.new(message_area).is_present?
    message.should == shouldnot.nil?
  rescue RSpec::Expectations::ExpectationNotMetError
    raise "message area #{shouldnot.nil? ? '' : ' not'} to be present but it doesn't."
  end
end

#This step is to verify message area should or should not contain message
Then /^message area should( not)? be contain messages?$/ do |shouldnot|
  message = "//div[@class = 'messageArea']/div[@class = 'message']"
  begin
    Element.new(message).is_present?.should == shouldnot.nil?
  rescue RSpec::Expectations::ExpectationNotMetError
    raise "message area #{shouldnot.nil? ? '' : ' not'} to be contain message but it doesn't."
  end
end