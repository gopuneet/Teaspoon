require 'mysql'
require 'teaspoon/connections/db_connection'

class MysqlConnection < DBConnection
  def initialize(data)
    @db = Mysql.connect(data[:url], data[:user], data[:password])
    @db_name = data[:db_name]
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
    ["CREATE SCHEMA IF NOT EXISTS `#{@db_name}` ;",
    "USE `#{@db_name}` ;",
    "CREATE TABLE IF NOT EXISTS `#{@db_name}`.`epoch_ids` ( `epoch` INT NOT NULL UNIQUE, `id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`)) ;",
    "CREATE TABLE IF NOT EXISTS `#{@db_name}`.`scenario_ids` ( `scenario` VARCHAR(255) NOT NULL UNIQUE, `id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`)) ;",
    "CREATE TABLE IF NOT EXISTS `#{@db_name}`.`branch_ids` ( `branch` VARCHAR(255) NOT NULL UNIQUE, `id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY (`id`)) ;",
    "CREATE TABLE IF NOT EXISTS `#{@db_name}`.`scenarios` ( `scenario_id` INT NOT NULL, `epoch_id` INT NOT NULL, `branch_id` INT NOT NULL, `success` TINYINT(1) NOT NULL, FOREIGN KEY (scenario_id) REFERENCES scenario_ids(id) ON DELETE CASCADE, FOREIGN KEY (epoch_id) REFERENCES epoch_ids(id) ON DELETE CASCADE, FOREIGN KEY (branch_id) REFERENCES branch_ids(id) ON DELETE CASCADE);"].each do |q|
      @db.query(q)
    end
  end

  def save_id(id_name, value)
    query = "INSERT IGNORE INTO #{id_name}_ids (#{id_name}) VALUES('#{value}');"
    @db.query(query)
    query = "SELECT id FROM #{id_name}_ids WHERE #{id_name} = '#{value}';"
    @db.query(query).fetch_row.fetch(0)
  end

  def data(constraints)
    q = 'SELECT epoch, branch, scenario, success FROM scenarios AS s LEFT JOIN epoch_ids AS ei ON ei.id = s.epoch_id LEFT JOIN scenario_ids AS si ON s.scenario_id = si.id LEFT JOIN branch_ids AS bi ON s.branch_id = bi.id '
    sq = 'WHERE '
    [:epoch, :branch, :scenario].each { |c| sq += "#{c}='#{constraints[c]}' AND " if constraints.key?(c)}
    q += sq.chomp('AND ') unless sq.eql?('WHERE ')
    q += ';'
    result_to_hash(@db.query(q))
  end

  def ids(constraints)
    key = constraints[:key]
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
    result.each{ |row| out.push(row.first) }
    out
  end
end
