# Passenger
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

set :application, "crm"
set :deploy_to, "/srv/#{application}"
set :keep_releases, 3

set :scm, :git
set :repository,  "git@github.com:railsdevmatt/fat_free_crm.git"
set :git_shallow_clone, 1
set :branch, "master"

set :user, "ubuntu"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

role :app, "23.21.197.126"
role :web, "23.21.197.126"
role :db,  "23.21.197.126", :primary => true

after "deploy:setup", :fix_perms
# ssh_options[:keys] = ["#{ENV['HOME']}/Desktop/important.pem"]

task :fix_perms do
  # sudo "chown apache:webshare -R /var/www/projects"
  # sudo "chmod 666 -R /var/www/projects/shared/log"
end

task :restart, :roles => :app, :except => { :no_release => true } do
   # run "touch #{current_path}/tmp/restart.txt"
end

after 'deploy:update_code' do
  run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
end


#  rm charities 
#  rm merchants
# ln -s /var/www/shopandsupport/shared/charities/ charities
# ln -s /var/www/shopandsupport/shared/merchants/ merchants