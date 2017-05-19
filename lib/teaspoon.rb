require 'dotenv'
require 'teaspoon/version'
require 'teaspoon/tea_timer'
require 'teaspoon/connections/connection_factory'
require 'teaspoon/data_parser'

module Teaspoon
  def self.measure(file_path)
    DataParser.statuses(file_path)
  end

  def self.pour(input, branch_name = 'master')
    epoch = Tea.time
    @conn = ConnectionFactory.create
    @conn.save(input, branch_name, epoch)
    @conn.close
  end

  def self.measure_and_pour(file_path, branch_name = 'master')
    input = measure(file_path)
    pour(input, branch_name)
  end

  def self.spoonful(constraints = {})
    @conn = ConnectionFactory.create
    result = @conn.retrieve(constraints)
    @conn.close
    result
  end
end
