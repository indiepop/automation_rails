require 'snmp'


=begin
SNMP::Manager.open(:host=>'10.6.195.17' ,:community=>'public') do |manager|
  manager.walk('1.3.6') do |row|
    row.each {|vb| puts "fuck#{vb}"}
  end
end
=end


def parse_tag(val)
  case val
    when 'Integer' then
      2
    when 'OctetString' then
      4
    when 'Null' then
      5
    when 'ObjectIdentifier' then
      6
    when 'IPAddress' then
      64
    when 'Counter32' then
      65
    when 'Gauge32' then
      66
    when 'TimeTicks' then
      67
    when 'Opaque' then
      68
    when 'Counter64' then
      70
    else
      5
  end
end

  # f = File.new("test.csv")
  #  f.each {|line| puts "#{f.lineno}: #{line}" }


@hellow=String.new

  fs= File.new("test.csv")
  fs.each_line do |line|
     if fs.lineno ==1
     else
    ar=line.split('","')
    @hellow << "#{ar[0].delete('"')}|#{parse_tag(ar[2])}|#{ar[1]}\n"
  end
  end
  puts @hellow



