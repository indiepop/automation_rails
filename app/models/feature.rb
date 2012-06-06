class Feature < ActiveRecord::Base
  has_many :sorts
  has_many :authors
end
