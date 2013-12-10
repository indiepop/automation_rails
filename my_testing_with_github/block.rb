def event(name)
  puts "Alert:#{name}" if yield
end

Dir.glob('*event.rb').each {|file| load file}