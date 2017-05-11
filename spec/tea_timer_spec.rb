require 'spec_helper'

RSpec.describe TeaTimer do
  it 'should tell the epoch time' do
    t = TeaTimer.time
    expect(t.class).to be Fixnum
    expect(t).to be > 1494495943
  end
end