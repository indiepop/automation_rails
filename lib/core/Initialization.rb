#require 'pathname'
#$:.unshift(Pathname.new(File.dirname(__FILE__)).parent.realpath)
class Initialization
  def self.start
    $browser ||= Array.new
      if  FileTest::exist?("#{$root}/lib/resource/execute_ip.yml")
        $is_remote['checked_ips'].each do |key,value|
        $browser[key] = SeleniumUtils.for :remote,:url=>"http://#{value}:4444/wd/hub",:desired_capabilities => ($info['browser'].to_sym )
        $browser[key].maximize_window
        $browser[key].navigate.to $info['server']
        end
      else
      $browser[0] = SeleniumUtils.for $info['browser'].to_sym
      $browser[0].maximize_window
      $browser[0].navigate.to $info['server']
      end

      end
end