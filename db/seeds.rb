# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#source for prenatal: http://www.indianwomenshealth.com/Immunization-During-Pregnancy-304.aspx
#source for postnatal: medibeep.com

Vaccination.delete_all
x = Vaccination.new
x.remID = 1
x.dab = -135
x.message = 'Take first dose tetanus vaccine'
x.save

x = Vaccination.new
x.remID = 2
x.dab = -111
x.message = 'Take second dose of tetanus vaccine'
x.save

#after birth. assuming it starts from here. 
x = Vaccination.new
x.remID = 3
x.dab = 7
x.message = 'Take BCG ; OPV zero ; Hepatitis B-1 vaccine'
x.save

x = Vaccination.new
x.remID = 4
x.dab = 42 # 6 weeks
x.message = 'Take OPV-1 + IPV-1 / OPV -1 vaccine, OPV alone if IPV cannot be given ; DTPw-1/DTPa-1 ; Hepatitis B-2 ; Hib-1'
x.save

x = Vaccination.new
x.remID = 5
x.dab = 60
x.message = 'Take OPV-2 + IPV-2 / OPV-2 OPV alone if IPV cannot be given ; DTPw-2/DTPa-2 ; Hib-2'
x.save

x = Vaccination.new
x.remID = 6
x.dab = 88
x.message = 'Take OPV-3 + IPV-3 / OPV-3 OPV alone if IPV cannot be given ; DTPw-1/DTPa-1 ; Hepatitis B-3 ; Hib-3'
x.save

x = Vaccination.new
x.remID = 7
x.dab = 275
x.message = 'Take Measles vaccine'
x.save

x = Vaccination.new
x.remID = 8
x.dab = 393
x.message = 'Take OPV-4 + IPV-B1 / OPV-4 OPV alone if IPV cannot be given ;  DTPw booster-1/DTPa booster-1 ; Hib booster ; MMR-1'
x.save

x = Vaccination.new
x.remID = 9
x.dab = 730
x.message = 'Take typhoid vaccine'
x.save

x = Vaccination.new
x.remID = 10
x.dab = 1825
x.message = 'Take OPV-5 ; DTPw-1/DTPa-1 ; DTPw booster-2/DTPa booster-2 ; MMR-2'
x.save

x = Vaccination.new
x.remID = 11
x.dab = 2190
x.message = 'Take typhoid vaccine'
x.save

x = Vaccination.new
x.remID = 12
x.dab = 3650
x.message = 'Take Tdap ; HPV (only girls)'
x.save
