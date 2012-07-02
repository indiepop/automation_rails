#require 'pathname'
#$:.unshift(Pathname.new(File.dirname(__FILE__)).parent.realpath)



class Initialization
  def self.start
    $browser = SeleniumUtils.for $info['browser'].to_sym
    $browser.maximize_window
    $browser.navigate.to $info['server']
  end
end
