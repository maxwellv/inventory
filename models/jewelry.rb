#NOTE TO SELF: WRITE MORE TESTS FOR THIS
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

  def self.get_jewelries(type)
    statement = "SELECT * FROM jewelries"
    if (type == 0) #user wants all jewelries
      statement += ";"
    else
      statement += " WHERE type == #{type};"
    end
    jewelries = Jewelry.execute_and_instantiate(statement)
    return jewelries
  end

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      new_jewelry = Jewelry.new(row["type"], row["materials_cost"], row["hours_worked"])
      new_jewelry.instance_variable_set(:@id, row["id"])
      results.push(new_jewelry)
    end
    return results
  end

  def cost
    return self.materials_cost + (self.hours_worked * 10.0)
  end

  def format_for_display
    type_strings = [nil, "Necklace", "Bracelet", "Earrings"] #types are stored one-indexed
    return type_strings[self.type].ljust(20) + sprintf("%0.02f", self.materials_cost).rjust(20) + self.hours_worked.to_s.rjust(20) + sprintf("%0.02f", self.cost).rjust(20)
  end

end
