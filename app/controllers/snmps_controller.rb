require 'snmp'
class SnmpsController < ApplicationController
  def index
    @machines=Machine.all
  end
  def walk

    @walking =  ["sysDescr.0",
                 "sysName.0",
                 "1.3.6.1.2.1.1.3.0",
                 "1.3.6.1.2.1.1.4.0 ",
                 "1.3.6.1.2.1.25.2.2.0"
    ]
    @strr = ""
    SNMP::Manager.open(:host => '10.6.197.17') do |manager|
      response = manager.get(@walking)
      response.each_varbind do |vb|
        temp=  <<EOF
#{vb.name.to_s}:  #{vb.value.to_s} \<br\>
EOF
        @strr+=temp
      end
    end
  end
end