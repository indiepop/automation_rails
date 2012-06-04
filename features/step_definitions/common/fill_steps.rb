# This step is to *type* into textbox
And /^I type '(.*)' in '(.+)' field$/ do |value, field_name|
  DwrElement.new(:find, field_name).set_value(value)
end

# This step is to fill *screen* or *box* fields.
#
# Table template:
#  | Field 1 title | Field 1 value |
#  | Field 2 title | Field 2 value |
#  | Field n title | Field n value |
When /^I fill '(.+)' (screen|dialog) with next values:$/ do |object_name, object_type, table|
  container = case object_type
                when "screen"
                  case object_name
                    when 'Agents' # TODO: refactor hack
                      AgentsScreen.new
                    else
                      Screen.new(object_name)
                  end
                when "dialog"
                  Dialog.new(object_name)
              end
  container.fill(table)
end

# This step is to upload file
#
# == Parameters:
#
#   [String] file path
#   [String] scope
#
# == Example:
#
#   I upload file "C:\pn\pne_100.license" in 'Install a License' dialog
#   I upload file "C:\pn\pne_100.license"
#
When /^I upload file "(.+)"( .+)?$/ do |file_path, scope|
  container_locator = $browser.get_container_locator_by_scope(scope)
  upload = Upload.new container_locator
  # need to convert / to \ in Windows
  upload.set_value(replace_string_variant(file_path).gsub('/', "\\"))
end

# This step is to type value into inline text editor of grid
#
# == Parameters:
#
#   [String] value you want to type
#
# == Example:
#
#   When I type 'test' in inline text editor
#
When /^I type '(.+)' in inline text editor$/ do |content|
  InlineTextEditor.new.set_value(content)
end

# This step is to select date in calendar
#
# == Parameters:
#
#   [String] date YYYY-MM-DD
#
# == Example:
#
#   When I select '2018-08-12' in calendar
#
When /^I select '(\d{4})-(\d{2})-(\d{2})' in calendar$/ do |year, month, day|
  calendar = Calendar.new("[unnamed]")
  calendar.select_year year
  calendar.select_month month
  calendar.select_day day
end