class Tag < ActiveRecord::Base
  has_many :feature_tag_ships
  has_many :features , :through =>  :feature_tag_ships
end
