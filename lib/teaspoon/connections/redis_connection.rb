require 'redis'
require 'db_connection'

class RedisConnection < DBConnection
  def initialize(data)
    @db = Redis.new
    @incremental_suffix = 'incr'
    super
  end

  def save(statuses, branch_name, timestamp)
    epoch_id = save_id('epoch', timestamp)
    branch_id = save_id('branch', branch_name)
    statuses.each do |status|
      scenario_id = save_id('scenario', status[:name])
      key = "#{scenario_id}:#{branch_id}:#{epoch_id}"
      @db.set(key, status[:status])
    end
  end

  def close
    @db.quit
  end

  private

  def configure
    %w(epoch branch scenario).each { |id| configure_increment(id) }
  end

  def configure_increment(increment_prefix)
    @db.setnx("#{increment_prefix}:#{@incremental_suffix}", '0')
  end

  def save_id(id_name, value)
    @db.sadd("#{id_name}:values", value)
    id = @db.get("#{id_name}:#{@incremental_suffix}")
    was_set = @db.setnx("#{id_name}:#{value}", id)
    @db.incr("#{id_name}:#{@incremental_suffix}") if was_set
    id
  end
end
