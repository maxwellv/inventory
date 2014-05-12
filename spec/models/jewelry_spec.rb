require_relative '../spec_helper'

describe Jewelry do
  context "new" do
    let(:jewelry){ Jewelry.new(jewelry_type: 1, materials_cost: 3.0, hours_worked: 1.5) }
    it "should make a new jewelry object" do
      jewelry.jewelry_type.should == 1
      jewelry.materials_cost.should == 3.0
      jewelry.hours_worked.should == 1.5
      end
  end

  context "create" do
    #let(:result){ Jewelry.connection.execute("Select * from jewelries") }
    let(:result){ Jewelry.all }
    let!(:jewelry){ Jewelry.create(jewelry_type: 1, materials_cost: 3.0, hours_worked: 1.5) }
    it "should record the new id" do
      result[0]["id"].should == jewelry.id
    end
    it "should only save one row to the database" do
      result.count.should == 1
    end
    it "should actually save it to the database" do
      result[0]["jewelry_type"].should == jewelry.jewelry_type
    end
  end

  context "cost" do
    let(:jewelry) { Jewelry.create(jewelry_type: 1, materials_cost: 3.0, hours_worked: 1.5) }
    it "should have a cost of 18.0" do
      #All jewelry has a cost equal to the materials price plus the hours worked * 10.
      jewelry.cost.should == 18.0
    end
  end

  context "get jewelries" do
    before do
      Jewelry.create(jewelry_type: 1, materials_cost: 3.0, hours_worked: 1.5)
      Jewelry.create(jewelry_type: 2, materials_cost: 9.0, hours_worked: 2.3)
      Jewelry.create(jewelry_type: 2, materials_cost: 4.5, hours_worked: 10.0)
      Jewelry.create(jewelry_type: 1, materials_cost: 3.3, hours_worked: 1.0)
      Jewelry.create(jewelry_type: 3, materials_cost: 1.0, hours_worked: 9.0)
      Jewelry.create(jewelry_type: 1, materials_cost: 11.0, hours_worked: 3.0)
    end
    it "should get all jewelries" do
      jewelries = Jewelry.get_jewelries(0)
      jewelries.length.should == 6
    end
    it "should get all jewelries of jewelry_type 1" do
      jewelries = Jewelry.get_jewelries(1)
      jewelries.length.should == 3
    end
    it "should get all jewelries of jewelry_type 2" do
      jewelries = Jewelry.get_jewelries(2)
      jewelries.length.should == 2
    end
    it "should get all jewelries of jewelry_type 3" do
      jewelries = Jewelry.get_jewelries(3)
      jewelries.length.should == 1
    end
  end

  context "format for display" do
    let!(:jewelry){ Jewelry.create(jewelry_type: 1, materials_cost: 2.0, hours_worked: 3.0) }
    let(:display){ jewelry.format_for_display }
    it "should look nice for displaying in the executable" do
      display.should == "Necklace                            2.00                 3.0               32.00"
    end
  end

  context "sell" do
    let!(:jewelry){ Jewelry.create(jewelry_type: 1, materials_cost: 2.0, hours_worked: 3.0) }
    it "should sell a piece of jewelry" do
      jewelry.sell
      Jewelry.get_jewelries(-1)[0].format_for_display.should == "Necklace                            2.00                 3.0               32.00"
    end
  end
end
