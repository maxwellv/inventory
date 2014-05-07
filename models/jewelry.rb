class Jewelry
  attr_reader :id
  attr_accessor :type
  attr_accessor :materials_cost
  attr_accessor :hours_worked

  def initialize(type, materials_cost, hours_worked)
    @type = type
    @materials_cost = materials_cost
    @hours_worked = hours_worked
  end

  def save
    statement = "INSERT INTO jewelries (type, materials_cost, hours_worked) VALUES (?, ?, ?);"
    Environment.database_connection.execute(statement, [type, materials_cost, hours_worked])
    @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
  end

  def self.create(type, materials_cost, hours_worked)
    jewelry = Jewelry.new(type, materials_cost, hours_worked)
    jewelry.save
    return jewelry
  end


end
