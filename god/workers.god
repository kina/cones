jobs = {}

2.times do |n|
  jobs.merge!({ "send_notifications#{n}" => "send_notifications" })
end

jobs.each do |key, value|
  God.watch do |w|
    w.name     = "resque-#{key}"
    w.group    = 'resque'
    w.interval = 30.seconds
    w.dir      = "#{@rails_root}"
    w.env      = { "RAILS_ENV" => @rails_env }

    w.uid = w.gid = 'cones' if @rails_env == 'production'

    w.start = "bundle exec env QUEUE=#{value} rake environment resque:work"
    #w.stop  ="bundle exec rake workers:stop RAILS_ENV=#{@rails_env}"

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 700.megabytes
        c.times = 2
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) { |c| c.running = true }
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) { |c| c.running = false }
    end
  end
end
