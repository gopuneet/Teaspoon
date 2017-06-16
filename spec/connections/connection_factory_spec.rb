require 'spec_helper'

RSpec.describe ConnectionFactory do
  it 'should return a DBConnection of the appropriate subclass' do
    {
      MYSQL: MysqlConnection,
      REDIS: RedisConnection,
      FILES: FileConnection
    }.each do |key, type|
      ENV['TEASPOON_DATABASE_IN_USE'] = key.to_s
      allow(type).to receive(:new).and_return(type)
      c = ConnectionFactory.create
      expect(c).to eq type
    end
  end
end
