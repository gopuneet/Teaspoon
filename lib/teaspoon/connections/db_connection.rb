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

  @@id_keys = [:epoch, :scenario, :branch].freeze

  class << self
    protected

    def ids?(constraints)
      constraints.key?(:key)
    end
  end
end
