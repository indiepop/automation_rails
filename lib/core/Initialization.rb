#require 'pathname'
#$:.unshift(Pathname.new(File.dirname(__FILE__)).parent.realpath)



class Initialization
  def self.start
  unless $is_remote.nil?
    $is_remote[checked_ips].each do |key,value|
    $browser = SeleniumUtils.for :remote,:url=>"http://#{value}:4444/wd/hub,:desired_capabilities =>#{$info['browser'].to_sym}"
    end

  else
    $browser = SeleniumUtils.for $info['browser'].to_sym
   end
    $browser.maximize_window
    $browser.navigate.to $info['server']
  end
end
