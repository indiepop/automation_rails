module WCF
  module Components

    # Represents vertical bar in the application usually by the title.
    class Metric < DwrElement

      # the class variant for mapping the icon file name to the severe level
      @@severe = {
          'fatal'    => 'fatal',
          'critical' => 'critical',
          'warning'  => 'warning',
          'normal'   => 'normal'
      }

    end
  end
end