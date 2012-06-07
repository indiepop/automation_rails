class Feature < ActiveRecord::Base
  validates :name ,:sort ,:author, :presence => true
  has_many :sorts
  has_many :authors
end
