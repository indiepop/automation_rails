class Machine < ActiveRecord::Base
  validates :name ,:presence => true
end
