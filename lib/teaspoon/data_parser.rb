require 'json'

module DataParser
  def self.statuses(report)
    out = []
    s = StatusParser.new
    report.map do |feature|
      feature[:elements].each { |scenario| out.push(s.status(scenario)) }
    end
    out
  end

  class StatusParser
    def status(scenario)
      name = sanitize("#{scenario[:name]}:#{scenario[:line]}")
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

    def sanitize(string)
      string.gsub(%r{\'|\"|\.|\*|\/|\-|\\}) { |match| "\\#{match}" }
    end
  end
end
