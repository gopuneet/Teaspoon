require 'json'

module DataParser
  def self.statuses(file_path)
    s = StatusParser.new
    json = s.read_execution(file_path)
    out = []
    json.each do |feature|
      feature[:elements].each { |scenario| out.push(s.status(scenario)) }
    end
    out
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

    def read_execution(file_path)
      report = File.open(file_path)
      data = report.read
      report.close
      JSON.parse(data, symbolize_names: true)
    end
  end
end
