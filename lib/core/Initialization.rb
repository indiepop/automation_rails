#require 'pathname'
#$:.unshift(Pathname.new(File.dirname(__FILE__)).parent.realpath)
class Initialization
  def self.start

      if  FileTest::exist?("#{$root}/lib/resource/execute_ip.yml")    #远程计算机执行环境
                $browser = SeleniumUtils.for :remote,:url=>"http://#{$is_remote[:checked_ip] }:4444/wd/hub",:desired_capabilities => ($info['browser'].to_sym )
                $browser.maximize_window
                $browser.navigate.to $info['server']
      else
      $browser = SeleniumUtils.for $info['browser'].to_sym
      $browser.maximize_window
      $browser.navigate.to $info['server']
      end
    end
end