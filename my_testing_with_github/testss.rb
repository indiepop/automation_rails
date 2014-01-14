
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



#`echo 1|sudo -S ifconfig eth0:test 10.30.178.252 netmask 255.255.255.255 up`


#puts  `echo 1|sudo -S ifconfig eth0:test down`



#puts `ps -fe|grep snmpsimd|grep -v grep|awk '{print "kill -9 ",$2}'|sh`
#puts `ps -fe|grep snmpsimd|grep -v grep`
#`echo 1 |sudo -S snmpsimd.py   --agent-udpv4-endpoint=10.30.178.252:161 --device-dir=/home/josh/RubyminePro/automation_rails/public/uploads/10.30.178.252 --process-user=josh --process-group=root >snmp.log 2>&1 &`
#system "ls"
# --logging-method=file:\dev\null\snmp.log