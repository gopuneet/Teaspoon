require 'spec_helper'

RSpec.describe DBConnection do
  before(:each) do
    @db = DBConnection.new({})
  end

  it 'should know what data to retrieve' do
    allow(@db).to receive(:ids).and_return(0)
    allow(@db).to receive(:data).and_return(1)
    expect(@db.retrieve(key: 'key')).to eql(0)
    expect(@db.retrieve(branch: 'branch')).to eql(1)
  end
end
