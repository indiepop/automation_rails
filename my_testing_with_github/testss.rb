
# puts `su root`
# puts `ifconfig eth0:test down`

=begin
def sudome
  if ENV["USER"] != "root"
    exec("sudo #{ENV['_']} #{ARGV.join(' ')}")
  end
end
=end
#puts ENV["USER"]
puts `who am i`


#`echo 1|sudo -S ifconfig eth0:test 10.30.178.252 netmask 255.255.255.255 up`


puts  `echo 1|sudo -S ifconfig eth0:test down`