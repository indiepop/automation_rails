class Feature < ActiveRecord::Base
  validates :name ,:sort ,:author, :presence => true
  has_many :sorts
  has_many :authors
  has_many :feature_tag_ships
  has_many :tags , :through => :feature_tag_ships
end
