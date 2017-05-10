require 'json'

module DataParser
  def self.epoch
    Time.now.to_i
  end

  def self.statuses(file_path)
    s = StatusParser.new
    json = read_execution(file_path)
    out = []
    json.each do |feature|
      feature[:elements].each { |scenario| out.push(s.status(scenario)) }
    end
    out
  end

  def self.read_execution(file_path)
    report = File.open(file_path)
    data = report.read
    report.close
    JSON.parse(data, symbolize_names: true)
  end

  class StatusParser
    def status(scenario)
      name = scenario[:name]
      pass = true
      steps = scenario[:before].to_a +
              scenario[:steps].to_a +
              scenario[:after].to_a
      steps.each { |step| pass &&= step[:result][:status].eql?('passed') }
      { name: name, status: pass }
    end
  end
end
