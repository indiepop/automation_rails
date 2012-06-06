# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   It is a test
FeatureType.delete_all
Author.delete_all

types=FeatureType.create([{name:'demo'},{name:'function'}])
authors=Author.create([{name:'Josh Yang'}])