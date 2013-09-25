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

require 'snmp'

$strr = "Hi, there"
SNMP::Manager.open(:host => '10.6.197.17') do |manager|
  response = manager.get(["sysDescr.0", "sysName.0","1.3.6.1.2.1.1.3.0","1.3.6.1.4.1.2021.11.9.0 "])
  response.each_varbind do |vb|
    temp=  <<EOF
       #{vb.name.to_s}:  #{vb.value.to_s}
EOF
  $strr+=temp
  end
end

puts $strr

