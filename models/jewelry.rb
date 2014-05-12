class Jewelry < ActiveRecord::Base

  def cost
    return self.materials_cost + (self.hours_worked * 10.0)
  end

  def self.get_jewelries(jewelry_type)
    if (jewelry_type == 0) #user wants all jewelries
      return Jewelry.all
    elsif (jewelry_type == -1)
      jewelries = Jewelry.connection.execute("SELECT * FROM jewelries_sold;")
      j2 = []
      jewelries.each do |j|
        j = Jewelry.new(jewelry_type: j['jewelry_type'], materials_cost: j['materials_cost'], hours_worked: j['hours_worked'], id:j['id'])
        j2.push(j)
      end
      return j2
    else
     return Jewelry.where(jewelry_type: jewelry_type)
    end
  end

  def format_for_display
    type_strings = [nil, "Necklace", "Bracelet", "Earrings"] #types are stored one-indexed
    return type_strings[self.jewelry_type].ljust(20) + sprintf("%0.02f", self.materials_cost).rjust(20) + self.hours_worked.to_s.rjust(20) + sprintf("%0.02f", self.cost).rjust(20)
  end

  def sell
    statement = "INSERT INTO jewelries_sold (jewelry_type, materials_cost, hours_worked, id) VALUES (#{self.jewelry_type}, #{self.materials_cost}, #{self.hours_worked}, #{self.id});"
    Jewelry.connection.execute(statement)
    self.destroy
  end
end
