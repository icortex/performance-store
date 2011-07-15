 namespace :bootstrap do
      desc "Add the default headquarter"
      task :default_headquarter => :environment do
        Headquarter.create( :name => 'Popayan')
        Headquarter.create( :name => 'Cali')
      end

      desc "Add the variables"
      task :variables => :environment do
        Variable.create( :key => 'IVA', :value => '16')
        Variable.create( :key => 'Dolar', :value => '1800')
        Variable.create( :key => 'Utilidad', :value => '20')
      end

      desc "Run all bootstrapping tasks"
      task :all => [:default_headquarter,:variables]
 end
