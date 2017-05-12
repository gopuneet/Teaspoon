class DBConnection

  def save(statuses, branch_name, timestamp); end

  def close; end

  def retrieve(constraints)
    return ids(constraints) if self.class.ids?(constraints)
    data(constraints)
  end

  protected

  def initialize(_)
    configure
  end

  def configure; end

  def data(_); end

  def ids(_); end

  def self.ids?(constraints)
    constraints.key?(:key)
  end
end
