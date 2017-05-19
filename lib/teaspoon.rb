require 'dotenv'
require 'teaspoon/version'
require 'teaspoon/tea_timer'
require 'teaspoon/connections/connection_factory'
require 'teaspoon/data_parser'

module Teaspoon
  def self.pour(file_path, branch_name = 'master')
    epoch = Tea.time
    statuses = DataParser.statuses(file_path)
    @conn = ConnectionFactory.create
    @conn.save(statuses, branch_name, epoch)
    @conn.close
  end

  def self.spoonful(constraints = {})
    @conn = ConnectionFactory.create
    result = @conn.retrieve(constraints)
    @conn.close
    result
  end
end
