class Snmp < ActiveRecord::Base

#  def upload_file=(field)
#    self.name=base_part_of(fieled.original_filename)
#    self.content_type = field.content_type.chomp
##    self.data=field.read
#  end
#  def base_part_of(file_name)
 #   File.basename(file_name).gsub(/[^\w._-]/)
 # end
validates_uniqueness_of  :name ,:simulated_ip
validates_presence_of :name,:simulated_ip

end
