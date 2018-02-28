require 'redis'
require 'teaspoon/connections/db_connection'

class RedisConnection < DBConnection
  def initialize(data)
    @db = Redis.new
    @incremental_suffix = 'incr'
    super
  end

  def save(statuses, branch_name, timestamp)
    super
    epoch_id = save_id('epoch', timestamp)
    branch_id = save_id('branch', branch_name)
    statuses.each do |status|
      scenario_id = save_id('scenario', status[:name])
      feature_id = save_id('feature', status[:feature])
      key = "scenarios:#{scenario_id}:#{feature_id}:#{branch_id}:#{epoch_id}"
      @db.set(key, status[:success])
    end
  end

  def close
    @db.quit
  end

  private

  def data(constraints = {})
    @@id_keys.each { |id| constraints[id] ||= ids(id) }
    scenarios = pipeline_get('scenario', constraints[:scenario])
    features = pipeline_get('feature', constraints[:feature])
    branches = pipeline_get('branch', constraints[:branch])
    epochs = pipeline_get('epoch', constraints[:epoch])

    keys_array = scenarios.product(features, branches, epochs)
    keys = []
    keys_array.each { |i| keys.push(i.join(':')) }

    r = pipeline_get('scenarios', keys)

    out = []
    keys_array.each_with_index do |v, i|
      out.push('epoch' => constraints[:epoch][epochs.index(v[3])],
               'branch' => constraints[:branch][branches.index(v[2])],
               'scenario' => constraints[:scenario][scenarios.index(v[0])],
               'success' => r[i].eql?('true'),
               'feature' => constraints[:feature][features.index(v[1])])
    end
    out.delete_if { |v| v['success'].nil? }
  end

  def pipeline_get(key, values)
    @db.pipelined { values.each { |v| @db.get("#{key}:#{v}") } }
  end

  def ids(key)
    q = "#{key}:values"
    @db.smembers(q)
  end

  def configure
    %w(epoch branch scenario feature).each { |id| configure_increment(id) }
  end

  def configure_increment(increment_prefix)
    @db.setnx("#{increment_prefix}:#{@incremental_suffix}", '0')
  end

  def save_id(id_name, value)
    @db.sadd("#{id_name}:values", value)
    id = @db.get("#{id_name}:#{@incremental_suffix}")
    was_set = @db.setnx("#{id_name}:#{value}", id)
    @db.incr("#{id_name}:#{@incremental_suffix}") if was_set
    @db.get("#{id_name}:#{value}")
  end
end
