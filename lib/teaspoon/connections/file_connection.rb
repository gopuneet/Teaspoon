require 'teaspoon/connections/db_connection'
require 'fileutils'
require 'json'

class FileConnection < DBConnection
  include FileUtils

  def initialize(data)
    @directory = data[:url]
    @epochs = @directory + 'epoch_ids.json'
    super
  end

  def save(statuses, branch_name, timestamp)
    File.open(@epochs, 'a').write("#{timestamp},")
    status_directory = "#{@directory}#{branch_name}/"
    FileUtils.mkdir_p(status_directory)
    out = []
    statuses.each { |status| out.push(status) }
    out = JSON.generate(out)
    File.open("#{status_directory}#{timestamp}.json", 'w')
        .write(JSON.generate(out))
  end

  def close
    @directory = ''
  end

  private

  def configure
    FileUtils.mkdir_p(@directory)
  end
end
