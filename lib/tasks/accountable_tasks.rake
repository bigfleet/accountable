namespace :accountable do
  desc "Explaining what the task does"
  task :update_balances => :environment do
   DetailAccount.all.each do |a|
     a.balance_at(Date.today).save
   end
  end
end
