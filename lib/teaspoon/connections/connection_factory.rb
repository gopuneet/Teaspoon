require 'teaspoon/connections/file_connection'
require 'teaspoon/connections/firebase_connection'
require 'teaspoon/connections/mysql_connection'
require 'teaspoon/connections/redis_connection'

module ConnectionFactory
  @connection_classes = {
      MYSQL: MysqlConnection,
      REDIS: RedisConnection,
      FILES: FileConnection,
      FIREBASE: FireBaseConnection
  }

  def self.create
    type = ENV['TEASPOON_DATABASE_IN_USE']
    out_class = @connection_classes.fetch(type.to_sym)
    out_class.new(select_env_vars(type))
  end

  def self.select_env_vars(db_name)
    env_prefix = "TEASPOON_#{db_name}_"
    out = ENV.select{|k| k =~ /#{env_prefix}.*/}.map do |var|
      [var[0].gsub(env_prefix, '').downcase.to_sym, var[1]]
    end
    Hash[out]
  end
end
