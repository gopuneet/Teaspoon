class DBConnection
  def initialize(_)
    configure
  end

  def save(statuses, branch_name, timestamp); end

  def close; end

  def retrieve(constraints)
    return ids(constraints) if ids?(constraints)
    data(constraints)
  end

  protected

  def configure; end

  def data(_); end

  def ids(_); end

  def ids?(constraints)
    constraints.key?(:key)
  end
end
