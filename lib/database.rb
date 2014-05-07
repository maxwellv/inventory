require "sqlite3"

class Database < SQLite3::Database
  def initialize(database)
    super(database)
    self.results_as_hash = true
  end

  def self.connection(environment)
    @connection ||= Database.new("db/inventory_#{environment}.sqlite3")
  end

  def create_tables
    self.execute("CREATE TABLE jewelries (id INTEGER PRIMARY KEY AUTOINCREMENT, type INTEGER, materials_cost REAL, hours_worked REAL)")
  end

  def execute(statement, bind_vars = [])
    Environment.logger.info("Executing: " + statement)
    super(statement, bind_vars)
  end
end
