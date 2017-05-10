require 'dotenv'
require 'teaspoon/version'
require 'teaspoon/connections/connection_factory'
require 'teaspoon/data_parser'

module Teaspoon
  def self.measure(file_path, branch_name)
    epoch = DataParser.epoch
    statuses = DataParser.statuses(file_path)
    @conn = ConnectionFactory.create
    @conn.save(statuses, branch_name, epoch)
    @conn.close
  end
end
