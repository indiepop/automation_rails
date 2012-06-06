class Feature < ActiveRecord::Base
  has_many :feature_types
  has_many :authors
end
