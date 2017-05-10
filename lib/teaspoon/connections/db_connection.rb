class DBConnection
  def initialize(_)
    configure
  end

  def save(statuses, branch_name, timestamp); end

  def close; end

  protected

  def configure; end
end
