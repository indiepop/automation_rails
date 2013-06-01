#require "pathname"
#require 'yaml'
#$root = Pathname.new(File.dirname(__FILE__)).parent.realpath.to_s     # so need pathname.rb  #to get the root name
#$info = YAML.load_file("#{$root}/lib/resource/info.yml")

# FileTest::exist?("#{$root}/lib/resource/execute_ip.yml")
#  $is_remote = YAML.load_file("#{$root}/lib/resource/execute_ip.yml")
#$is_remote = YAML.load_file("#{$root}/lib/resource/execute_ip.yml")
#puts $root, $info,$is_remote
#puts $is_remote['checked_ips'].nil?
#puts $is_remote['checked_ips']

=begin
$is_remote['checked_ips'].each do |key,value|
  puts key, value
end
=end

2.times do |x|
p x
#puts "tttttt#{(x-1)}"
end


