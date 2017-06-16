require 'spec_helper'

RSpec.describe DataParser do
  it 'should be able to parse a status' do
    statuses = DataParser.statuses('spec/sample_report.json')
    expected = [
      { name: 'Passing:5', status: true },
      { name: 'Failing:9', status: false }
    ]
    expect(statuses).to eq(expected)
  end
end
