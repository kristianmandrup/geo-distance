require 'spec_helper'

describe "GeoDistance core extensions" do
  it "should work" do
    5.km.should be_kind_of GeoDistance::Distance
    5.km.distance.should == 5
    5.km.unit.should == :km
  end
end
