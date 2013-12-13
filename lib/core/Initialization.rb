#require 'pathname'
#$:.unshift(Pathname.new(File.dirname(__FILE__)).parent.realpath)
class Initialization
  def self.start

      if  FileTest::exist?("#{$root}/lib/resource/execute_ip.yml")    #多计算机执行环境

        $threads = []
        $is_remote['checked_ips'].each do |key,value|      #$is_remote是个hash

           $threads << Thread.new(value) do
                begin
                $browser = SeleniumUtils.for :remote,:url=>"http://#{value}:4444/wd/hub",:desired_capabilities => ($info['browser'].to_sym )
                $browser.maximize_window
                $browser.navigate.to $info['server']
                rescue
                  retry
              end
            end
          end
      else
      $browser = SeleniumUtils.for $info['browser'].to_sym
      $browser.maximize_window
      $browser.navigate.to $info['server']
      end
  end

end