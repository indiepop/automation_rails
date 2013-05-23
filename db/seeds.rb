# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   It is a test
Sort.delete_all
Author.delete_all
MachineType.delete_all

Sort.create([{sort_id:1,name:'demo'},{sort_id:2,name:'function'}])
Author.create([{author_id:1,name:'Josh Yang'}])
MachineType.create([{machine_type_id:1,name:'Windows'},{machine_type_id:2,name:'Unix'},{machine_type_id:3,name:'Linux'},{machine_type_id:4,name:'Mac'},{machine_type_id:5,name:'Iphone'},{machine_type_id:6,name:'Android'}])