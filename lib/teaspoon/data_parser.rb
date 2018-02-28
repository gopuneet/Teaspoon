require 'json'

module DataParser
  def self.statuses(report)
    out = []
    s = StatusParser.new
    report.map do |feature|
      feature[:elements].each do |scenario|
        out.push(s.status(scenario, feature[:id]))
      end
    end
    out
  end

  class StatusParser
    def status(scenario, feature_name)
      name = sanitize("#{scenario[:name]}:#{scenario[:line]}")
      pass = true
      steps = scenario[:before].to_a + scenario[:steps].to_a + scenario[:after].to_a
      steps.each { |step| pass &&= step[:result][:status].eql?('passed') }
      { name: name, success: pass, feature: feature_name }
    end

    def sanitize(string)
      string.gsub(%r{\'|\"|\.|\*|\/|\-|\\}) { |match| "\\#{match}" }
    end
  end
end
