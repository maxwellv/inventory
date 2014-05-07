require_relative '../spec_helper'

describe "Menu integration" do
  let(:menu_text) do
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

  context "the menu and welcome text both display on startup" do
    welcome_text = "Welcome to the jewelry inventory management program."
    let(:shell_output) { run_inventory_with_input("6") }
    it "should print the welcome text first" do
      shell_output.should include(welcome_text)
    end
    it "should also print the menu text" do
      shell_output.should include(menu_text)
    end
  end

  context "the user wants to add jewelry" do
    let(:shell_output) { run_inventory_with_input("1", "2", "2", "2", "6") }
    it "should ask the user to start inputting jewelry" do
      shell_output.should include("Enter the jewelry type (1 for necklaces, 2 for bracelets, or 3 for earrings): ")
    end
  end

  context "the user wants to see necklaces in inventory" do
    let(:shell_output) { run_inventory_with_input("2", "6") }
    it "should start displaying necklaces" do
      shell_output.should include("Total Necklaces in Inventory:");
    end
  end

  context "the user wants to see bracelets in inventory" do
    let(:shell_output) { run_inventory_with_input("3", "6") }
    it "should start displaying bracelets" do
      shell_output.should include("Total Bracelets in Inventory:");
    end
  end

  context "the user wants to see earrings in inventory" do
    let(:shell_output) { run_inventory_with_input("4", "6") }
    it "should start displaying earrings" do
      shell_output.should include("Total Earrings in Inventory:");
    end
  end

  context "the user wants to see all inventory" do
    let(:shell_output) { run_inventory_with_input("5", "6") }
    it "should start displaying everything" do
      shell_output.should include("Total Pieces of jewelry in Inventory:");
    end
  end

  context "the user wants to quit" do
    let(:shell_output) { run_inventory_with_input("6") }
    it "should quit" do
      shell_output.should include("Thank you for using this program.");
    end
  end

  context "the menu should handle bad user input" do
    let(:shell_output) { run_inventory_with_input("bad input", "6") }
    it "should tell the user off" do
      shell_output.should include("Invalid entry.")
    end
  end
end
