require 'spec_helper'

RSpec.describe Tea do
  it 'should tell the epoch time' do
    t = Tea.time
    expect(t.class).to be Fixnum
  end
end
