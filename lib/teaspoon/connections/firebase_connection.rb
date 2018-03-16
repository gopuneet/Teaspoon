require 'teaspoon/connections/db_connection'
require 'firebase'

class FireBaseConnection < DBConnection
  @@PATH = 'statuses'

  def initialize(data)
    private_key = File.read(data.fetch(:private_key_path))
    @db = Firebase::Client.new(data.fetch(:url), private_key)
    super
  end

  def save(statuses, branch_name, timestamp)
    super
    constant_data = {branch: branch_name, epoch: timestamp}
    data = statuses.map { |status| status.merge(constant_data) }
    @db.push(@@PATH, data)
  end

  def close

  end

  private

  def data(constraints = {})
    raw = @db.get(@@PATH).body
    treated = raw.values.flatten.map do |scenario|
      symbolize_keys(scenario).tap do |scenario|
        scenario[:scenario] = scenario[:name]
        scenario.delete(:name)
      end
    end
    treated.select do |scenario|
      @@id_keys.map do |key|
        constraints[key] ? constraints[key].include?(scenario[key]) : true
      end.all?
    end
  end

  def ids(key)

  end

  def symbolize_keys(hash)
    Hash[hash.map { |k,v| [k.to_sym, v] } ]
  end
end
