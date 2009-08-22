namespace :bg do
  desc 'Update Raffles'
  task :update_raffles => :environment do
    Raffle.for_update.each do |r|
      RaffleUpdater.new(r).update
    end
  end
end
