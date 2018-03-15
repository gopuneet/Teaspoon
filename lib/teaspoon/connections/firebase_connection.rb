require 'teaspoon/connections/db_connection'
require 'firebase'

class FireBaseConnection < DBConnection
  def initialize(data)
    private_key = File.read(data.fetch[:private_key_path])
    @db = Firebase::Client.new(data.fetch(:url), private_key)
    super
  end

  def save(statuses, branch_name, timestamp)
    super
  end

  def close

  end

  private

  def configure

  end

  def data(constraints = {})

  end

  def ids(key)

  end
end
