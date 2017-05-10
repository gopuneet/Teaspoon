require 'mysql'
require 'teaspoon/connections/db_connection'

class MysqlConnection < DBConnection
  def initialize(data)
    @db = Mysql.connect(data[:url], data[:user], data[:password])
    super
  end

  def save(statuses, branch_name, timestamp)
    branch_id = save_id('branch', branch_name)
    epoch_id = save_id('epoch', timestamp)
    query = 'INSERT INTO scenarios '\
            '(branch_id, scenario_id, epoch_id, success) VALUES'
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
    File.open('teaspoon/Create.sql').read.split("\n").each { |q| @db.query(q) }
  end

  def save_id(id_name, value)
    query = "INSERT IGNORE INTO #{id_name}_ids (#{id_name}) VALUES('#{value}');"
    @db.query(query)
    query = "SELECT id FROM #{id_name}_ids WHERE #{id_name} = '#{value}';"
    @db.query(query).fetch_row.fetch(0)
  end
end
