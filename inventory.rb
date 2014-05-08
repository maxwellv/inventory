#!/usr/bin/env ruby

$LOAD_PATH << "lib"
$LOAD_PATH << "models"

require 'environment'
Environment.environment = ENV["ENVIRONMENT"] || "production" #Specify an environment variable at runtime to change this (example: "ENVIRONMENT=test ruby inventory.rb")
#$stderr = $stdout

require "jewelry"

def menu_text
<<EOS
1. Add jewelry to inventory.
2. Calculate totals for all necklaces.
3. Calculate totals for all bracelets.
4. Calculate totals for all earrings.
5. Calculate totals for all jewelry in inventory.
6. Quit.
Enter a number from 1 to 6:
EOS
end

def add_jewelry
  #These inputs from the user are nested in loops since I want to provide the user with a chance to not have to redo a bunch of work should he or she make one mistake. If we did validity checking in the jewelry class, we'd have to take all three inputs and make the object before possibly yelling at the user.
  while true
    puts "Enter the jewelry type (1 for necklaces, 2 for bracelets, or 3 for earrings): "
    type = gets.to_i
    if (type < 1 || type > 3)
      puts "Invalid type."
    else
      break
    end
  end
  while true
    puts "Enter the materials cost for this piece of jewelry: "
    materials_cost = gets.to_f
    if (materials_cost <= 0.0)
      puts "Invalid cost (materials cost must be greater than zero)."
    else
      break
    end
  end
  while true
    puts "Enter the hours worked on this piece of jewelry: "
    hours_worked = gets.to_f
    if (hours_worked <= 0.0)
      puts "Invalid hours (hours worked must be greater than zero)."
    else
      break
    end
  end
  new_jewelry = Jewelry.create(type, materials_cost, hours_worked)
  puts "SUCCESS. A jewelry with type #{new_jewelry.type}, materials cost #{new_jewelry.materials_cost}, and hours worked #{new_jewelry.hours_worked} was entered into the database."
end

def show_jewelry(menu_choice)
  if (menu_choice == 2)
    puts "Total Necklaces in Inventory:"
    type = 1
  elsif (menu_choice == 3)
    puts "Total Bracelets in Inventory:"
    type = 2
  elsif (menu_choice == 4)
    puts "Total Earrings in Inventory:"
    type = 3
  elsif (menu_choice == 5)
    puts "Total Pieces of jewelry in Inventory:"
    type = 0
  end
  jewelries = Jewelry.get_jewelries(type)
  #todo: somehow go through the tables array and actually format the data
  puts jewelries
end

def get_menu_selection
  puts menu_text
  menu_choice = gets.to_i
  return unless menu_choice
  if (menu_choice == 1)
    add_jewelry
  elsif (menu_choice > 1 && menu_choice < 6)
    show_jewelry(menu_choice)
  elsif (menu_choice == 6)
    puts "Thank you for using this program."
    exit
  else
    puts "Invalid entry."
  end
end

puts "Welcome to the jewelry inventory management program." #this only runs once, right here
while true
  get_menu_selection
end
