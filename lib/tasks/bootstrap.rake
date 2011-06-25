 namespace :bootstrap do
      desc "Add the default headquarter"
      task :default_headquarter => :environment do
        Headquarter.create( :name => 'default')
      end

      desc "Run all bootstrapping tasks"
      task :all => [:default_headquarter]
    end
