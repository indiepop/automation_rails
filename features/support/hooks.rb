#when a feature is begin or end ,what they do .

require "pathname"
Before do
  $root = Pathname.new(File.dirname(__FILE__)).parent.parent.realpath.to_s     # so need pathname.rb  #to get the root name
  $info = YAML.load_file("#{$root}/lib/resource/info.yml")
  if FileTest::exist?("#{$root}/lib/resource/execute_ip.yml")
    $is_remote = YAML.load_file("#{$root}/lib/resource/execute_ip.yml")
  end
end                                                                         #start


After do
  # Be sure to close the browser if it's still open
  if $browser
 #   $browser.each do |browser|
  $browser = nil
 # end
  end                                                                    #one scenario ends
end

at_exit do
  # Be sure to close the browser if it's still open
  if $browser

    $browser.quit
    #browser = nil
                                               #one feature ends
  end
  if $threads
    $threads.each{|t|t.join}
  end
end
