# This step is to *click* on *objects*.
# @note Possible objects is: button, link, checkbox, tile, tab, inventory.
When /^I click (?:the )?(?:(\d+)(?:st|nd|rd|th) )?'(.+)' (button|link|tile|inventory|radio|tab|radiobox|icon|message button|checkbox|action|calendar)( .+)?$/ do |index, object_name, object_type, scope|
  container_locator = $browser.get_container_locator_by_scope(scope)
  index ||= 1
  case object_type
    when "button"
      Button.new(object_name, container_locator, index).click
      if object_name.downcase == "apply"
        $browser.wait_for_body_text
      end
    when "link"
      Link.new(object_name, container_locator, index).click
    when "tile"
      TileBox.new(object_name, container_locator, index).click
    when "tab"
      Tab.new(object_name, container_locator, index).click
    when "inventory"
      Inventory.new(object_name, container_locator, index).click
    when "radio", "radiobox"
      DwrContainer.new("//html").set_value(object_name, "on")
    when "icon"
      Icon.new(object_name, container_locator, index).click
    when "message button"
      MessageButton.new.click
    when "checkbox"
      object_name = "" if object_name == "[unnamed]"
      checkbox = CheckBox.new(:locator, "#{container_locator}//div[contains(.,'#{object_name}') and input[@type='checkbox']][#{index}]//input")
      if checkbox.is_present?
        checkbox.toggle
      else
        CheckBox.new(object_name, container_locator, index).toggle
      end
    when "action"
      Action.new(object_name, container_locator, index).click
    when "calendar"
      Calendar.new(object_name, container_locator, index).click
    else
      raise "Unknown object type: #{object_type}."
  end
end

# This step is to *navigate* (expand all element through) inside tree.
When /^I navigate to '(.+)' in '(.*)' tree$/ do |path, object_name|
  paths = path.split('->').map! { |element| element.strip }
  if object_name == 'Topology'
    collapsible = Collapsible.new(paths.shift)
    collapsible.expand
    tree = collapsible.get_element(TreeWcfTable)
  elsif object_name == 'Definitions'
    tree = Tree.new(object_name)
  else
    tree = TreeWcfTable.new(object_name)
    if object_name == paths[0]
      paths.shift
    end
  end
  tree.navigate(paths)
  tree.click_element(paths)
  $browser.wait_for_body_text
end