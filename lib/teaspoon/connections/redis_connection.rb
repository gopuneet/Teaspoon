require 'redis'
require 'teaspoon/connections/db_connection'

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

  def data(constraints)
    epochs = get_ids(constraints[:epoch], 'epoch')
    branches = get_ids(constraints[:branch], 'branch')
    scenarios = get_ids(constraints[:scenario], 'scenario')
    r = true
  end

  def get_ids(constraint, key)
    return all_ids(key) if constraint.nil?
    pipeline(key, constraint)
  end

  def all_ids(key)
    values = ids(key: key)
    pipeline(key, values)
  end

  def pipeline(key, values)
    @db.pipelined { values.each { |v| @db.get("#{key}:#{v}")} }
  end

  def ids(constraints)
    q = "#{constraints[:key]}:values"
    @db.smembers(q)
  end

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
