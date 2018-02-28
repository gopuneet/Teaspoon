require 'json'

module DataParser
  def self.statuses(report)
    out = []
    s = StatusParser.new
    report.map do |feature|
      feature[:elements].each do |scenario|
        parsed_scenario = s.status(scenario)
        parsed_scenario[:feature] = feature[:id]
        out.push(parsed_scenario)
      end
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
      { name: name, success: pass }
    end

    def sanitize(string)
      string.gsub(%r{\'|\"|\.|\*|\/|\-|\\}) { |match| "\\#{match}" }
    end
  end
end
