require 'json'

module DataParser
  def self.statuses(report)
    out = []
    report.map do |feature|
      feature[:elements].each do |scenario|
        out.push(status(scenario, feature[:id]))
      end
    end
    out
  end

  def self.status(scenario, feature_name)
    name = sanitize("#{scenario[:name]}:#{scenario[:line]}")
    pass = true
    steps = scenario[:before].to_a + scenario[:steps].to_a + scenario[:after].to_a
    steps.each { |step| pass &&= step[:result][:status].eql?('passed') }
    { name: name, success: pass, feature: feature_name }
  end

  def self.sanitize(string)
    string.gsub(%r{\'|\"|\.|\*|\/|\-|\\}) { |match| "\\#{match}" }
  end

  private_class_method :status
end
