require 'spec_helper'

describe "GeoDistance class methods" do
  before do
    from = [-104.88544, 39.06546].geo_point
    to =   [-104.80, lat1].geo_point
  end

  describe '#default_algorithm' do
    it "should work" do
      GeoDistance.default_algorithm = :haversine

      dist = GeoDistance.distance( lat1, lon1, lat2, lon2 )

      puts "the distance from  #{lat1}, #{lon1} to #{lat2}, #{lon2} is: #{dist.meters} meters"

      dist.feet.should == 24193.0
      dist.to_feet.should == 24193.0
      dist.kms.to_s.should match(/7\.376*/)
    end
  end
end
