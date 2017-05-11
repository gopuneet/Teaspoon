require 'teaspoon/connections/mysql_connection'
require 'teaspoon/connections/redis_connection'
require 'teaspoon/connections/file_connection'

module ConnectionFactory
  @connection_classes = {
    MYSQL: MysqlConnection,
    REDIS: RedisConnection,
    FILES: FileConnection
  }

  def self.create
    type = ENV['DATABASE_IN_USE'].to_sym
    out_class = @connection_classes.fetch(type)
    out_class.new(
      url: ENV["#{type}_URL"],
      user: ENV["#{type}_USER"],
      password: ENV["#{type}_PASSWORD"],
      db_name: ENV["#{type}_NAME"]
    )
  end
end
