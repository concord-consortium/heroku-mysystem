require 'fileutils'
@mysystem_git_ulr = "git://github.com/concord-consortium/mysystem_sc.git"
@checkout_path = File.join(Rails.root,'tmp','mysystem_sc')
@static_path = File.join(@checkout_path,'tmp','build','static')
@public_path = File.join(Rails.root,'public')

namespace :mysys do
  desc 'remove existing mysystem build'
  task :clean do
    FileUtils.rm_rf(@static_path)
  end

  desc "checkout code"
  task :checkout_code do
    `git clone #{@mysystem_git_ulr} #{@checkout_path}`
  end

  file @checkout_path do
    Rake::Task['mysys:checkout_code'].invoke
  end

  desc "update code"
  task :update_code => @checkout_path do
    Dir.chdir @checkout_path do
      puts `git pull`
      puts `git submodule update --init --recursive`
    end
  end

  desc "build"
  task :build => :update_code do
    Dir.chdir @checkout_path do
      Bundler.with_clean_env do
        puts `bundle install`
        puts `bundle exec rake`
      end
    end
  end

  file @static_path do 
    Rake::Task['mysys:build'].invoke
  end

  desc "copy files"
  task :copy_files => @static_path do 
    Dir.chdir @public_path do
      from_path = @static_path
      to_path = File.join(@public_path,'static')
      FileUtils.rm_rf(File.join(@public_path,'index.html'))
      FileUtils.rm_rf(to_path)
      FileUtils.cp_r(from_path, to_path) 

      # link index file:
      index_file = `find #{to_path} -name index.html`.strip
      FileUtils.cp(index_file, @public_path)

      # copy the authoring folder:
      from_path = File.join(@checkout_path,'public','authoring')
      to_path = File.join(@public_path,'authoring')
      FileUtils.rm_rf(to_path)
      FileUtils.cp_r(from_path, to_path)

      #add our authoring.html file:
      from_path = File.join(@public_path,'authoring.html')
      to_path = File.join(@public_path,'authoring','authoring.html')
      FileUtils.cp(from_path,to_path)
    end
  end

  desc "build mysystem runtime"
  task :make => :copy_files

end
