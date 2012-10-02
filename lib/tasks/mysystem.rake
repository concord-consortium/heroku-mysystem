include Process
@mysystem_git_ulr = "git://github.com/concord-consortium/mysystem_sc.git"
@checkout_path = File.join(Rails.root,'tmp','mysystem_sc')
@public_path = File.join(Rails.root,'public')

desc "checkout code"
task :checkout_code do
  `git clone #{@mysystem_git_ulr} #{@checkout_path}`
end

desc "update code"
task :update_code do
  Dir.chdir @checkout_path do
    puts `git pull`
    puts `git submodule update --init --recursive`
  end
end

desc "build"
task :build do
  Dir.chdir @checkout_path do
    Bundler.with_clean_env do
      puts "running bundle install in #{`pwd`}"
      puts `bundle install`
      puts "running bundel exec rake in #{`pwd`}"
      puts `bundle exec rake`
    end
  end
end

desc "copy files"
task :copy_Files do
  `mv #{@checkout_path}/tmp/build/static #{@public_path}`
end
