require 'mysql'
require 'teaspoon/connections/db_connection'

class MysqlConnection < DBConnection
  def initialize(data)
    @db = Mysql.connect(data[:url], data[:user], data[:password])
    @db_name = data[:db_name]
    @commands_directory = 'mysql_commands'
    super
  end

  def save(statuses, branch_name, timestamp)
    branch_id = save_id('branch', branch_name)
    epoch_id = save_id('epoch', timestamp)
    query = load_query_file('save.sql')
    statuses.each do |status|
      scenario_id = save_id('scenario', status[:name])
      query += "(#{branch_id}, #{scenario_id}, "\
               "#{epoch_id}, #{status[:status]}),"
    end
    @db.query(query.chomp(','))
  end

  def close
    @db.close
  end

  private

  def configure
    commands = load_query_file('configure.sql').gsub!('@db_name', @db_name).split("\n")
    commands.each { |q| @db.query(q) }
  end

  def save_id(id_name, value)
    query = "INSERT IGNORE INTO #{id_name}_ids (#{id_name}) VALUES('#{value}');"
    @db.query(query)
    query = "SELECT id FROM #{id_name}_ids WHERE #{id_name} = '#{value}';"
    @db.query(query).fetch_row.fetch(0)
  end

  def data(constraints)
    q = load_query_file('data.sql')
    sq = []
    @@id_keys.each do |c|
      sq.push("#{c} IN (#{constraints[c].map { |e| "'#{e}'" }.join(', ')}) ") if constraints.key?(c)
    end
    q += " WHERE #{sq.join('AND ')} ;" unless sq.empty?
    result_to_hash(@db.query(q))
  end

  def ids(key)
    q = "SELECT #{key} FROM #{key}_ids"
    result_to_array(@db.query(q))
  end

  def result_to_hash(result)
    out = []
    result.each_hash { |row| out.push(row) }
    out
  end

  def result_to_array(result)
    out = []
    result.each { |row| out.push(row.first) }
    out
  end

  def load_query_file(file_path)
    File.open(File.join(File.dirname(__FILE__), @commands_directory, file_path)).read
  end
end
