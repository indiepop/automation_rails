#when a feature is begin or end ,what they do .

require "pathname"
Before do
  $root = Pathname.new(File.dirname(__FILE__)).parent.parent.realpath.to_s     # so need pathname.rb  #to get the root name
  $info = YAML.load_file("#{$root}/lib/douban_resource/info.yml")
end


at_exit do
  # Be sure to close the browser if it's still open
  if $browser
    $browser.close
    $browser = nil
  end
end
