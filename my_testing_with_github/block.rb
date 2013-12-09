def block
 yield if block_given?
 "no block"
end




block{puts "I'm block"}