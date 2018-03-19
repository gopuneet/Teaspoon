module Keys
  def self.in_database(type, branch, epoch)
    return [branch] if type.eql?('branche')
    return [epoch] if type.eql?('epoch')
    return %w(Passing:5 Failing:9 Passing:5 Failing:9) if type.eql?('scenario')
    return %w(one-passing-scenario,-one-failing-scenario one-failing-scenario,-one-passing-scenario) if type.eql?('scenario')
  end
end