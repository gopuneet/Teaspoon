require 'spec_helper'

RSpec.describe TeaTimer do
  it 'should tell the epoch time' do
    t = TeaTimer.time
    expect(t.class).to be Integer
    expect(t).to be > 1_494_495_943
  end
end
