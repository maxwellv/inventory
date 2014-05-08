require_relative '../spec_helper'

describe Jewelry do
  context "new" do
    let(:jewelry){ Jewelry.new(1, 3.0, 1.5) }
    it "should make a new jewelry object" do
      jewelry.type.should == 1
      jewelry.materials_cost.should == 3.0
      jewelry.hours_worked.should == 1.5
      end
  end

  context "create" do
    let(:result){ Environment.database_connection.execute("Select * from jewelries") }
    let!(:jewelry){ Jewelry.create(1, 3.0, 1.5) }
    it "should record the new id" do
      result[0]["id"].should == jewelry.id
    end
    it "should only save one row to the database" do
      result.count.should == 1
    end
    it "should actually save it to the database" do
      result[0]["type"].should == jewelry.type
    end
  end

  context "cost" do
    let(:jewelry) { Jewelry.create(1, 3.0, 1.5) }
    it "should have a cost of 18.0" do
      #All jewelry has a cost equal to the materials price plus the hours worked * 10.
      jewelry.cost.should == 18.0
    end
  end

  context "get jewelries" do
    before do
      Jewelry.create(1, 3.0, 1.5)
      Jewelry.create(2, 9.0, 2.3)
      Jewelry.create(2, 4.5, 10.0)
      Jewelry.create(1, 3.3, 1.0)
      Jewelry.create(3, 1.0, 9.0)
      Jewelry.create(1, 11.0, 3.0)
    end
    it "should get all jewelries" do
      jewelries = Jewelry.get_jewelries(0)
      jewelries.length.should == 6
    end
    it "should get all jewelries of type 1" do
      jewelries = Jewelry.get_jewelries(1)
      jewelries.length.should == 3
    end
    it "should get all jewelries of type 2" do
      jewelries = Jewelry.get_jewelries(2)
      jewelries.length.should == 2
    end
    it "should get all jewelries of type 3" do
      jewelries = Jewelry.get_jewelries(3)
      jewelries.length.should == 1
    end
  end

end
