require 'teaspoon/connections/db_connection'
require 'fileutils'
require 'json'

class FileConnection < DBConnection
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
        .write(out)
  end

  def close
    @directory = ''
  end

  private

  def configure
    FileUtils.mkdir_p(@directory)
  end

  def data(constraints)
    branches = constraints[:branch] || ids('branch')
    epochs = constraints[:epoch] || ids('epoch')

    out = []
    branches.each do |branch|
      dir = "#{@directory}#{branch}/"
      epochs.each do |epoch|
        file_path = "#{dir}#{epoch}.json"
        next unless File.exist?(file_path)
        out.push(branch: branch, epoch: epoch, scenarios: File.open(file_path).read)
      end
    end
    out
  end

  def ids(key)
    return File.open(@epochs).read.split(',').uniq if key.eql?('epoch')
    return branches if key.eql?('branch')
  end

  def branches
    Dir.entries('cucumber_history').select do |entry|
      File.directory? File.join('cucumber_history', entry) && !(entry =='.' || entry == '..')
    end
  end
end
