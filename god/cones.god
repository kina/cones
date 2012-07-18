# load in all god configs

@rails_env   = ENV['RAILS_ENV']  || "production"
@rails_root  = ENV['RAILS_ROOT'] || "/var/www/cones"
@conf_dir    = File.dirname(__FILE__)

puts <<-GOD
            god configuration:
            RAILS_ENV  : #{@rails_env}
            RAILS_ROOT : #{@rails_root}
            conf_dir   : #{@conf_dir}
        GOD

require 'god'
God.terminate_timeout=123

%w(workers
   scheduler).each { |god_file| God.load File.join(@conf_dir, "#{god_file}.god") }