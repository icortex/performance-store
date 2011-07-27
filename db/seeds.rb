# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Variable.create(:key => 'IVA', :value => '16')
Variable.create(:key => 'Dolar', :value => '1800')
Variable.create(:key => 'Utilidad', :value => '20')

Headquarter.create(:name => 'Sede')

User.create(:username=>'admin', :email=>'admin@performance.com', :type=>'Admin',:password=>'admin123', :validated=>'1')