# # Modules: Whenever
# Adds settings and tasks for managing projects with [whenever].
#
# [whenever]: http://rubygems.org/gems/whenever
#
#
# ## Common usage
#     require 'mina/whenever'
#
#     task :deploy => :environment do
#       deploy do
#         ...
#       to :launch do
#         invoke :'whenever:update'
#       end
#     end

# ## Settings
# Any and all of these settings can be overriden in your `deploy.rb`.

# ### whenever_name
# Sets the name for whenever_name.

set_default :whenever_name, "#{domain}_#{rails_env}"

namespace :whenever do
  desc "Clear crontab"
  task :clear => :environment  do
    queue %{
      echo "-----> Clear crontab for #{whenever_name}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; #{bundle_bin} exec whenever --clear-crontab #{whenever_name} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end
  desc "Update crontab"
  task :update => :environment do
    queue %{
      echo "-----> Update crontab for #{whenever_name}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; #{bundle_bin} exec whenever --update-crontab #{whenever_name} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end
  desc "Write crontab"
  task :write => :environment do
    queue %{
      echo "-----> Update crontab for #{whenever_name}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; #{bundle_bin} exec whenever --write-crontab #{whenever_name} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end
end
