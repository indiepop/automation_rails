class Initialization
  def self.start
    $browser = SeleniumUtils.for :firefox, :profile => "max"
    $browser.maximize_window
    $browser.navigate.to $config['server']
  end
end