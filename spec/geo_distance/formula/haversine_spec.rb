require 'spec_helper'

describe GeoDistance::Haversine do
  let(:from)  { [-104.88544, 39.06546].geo_point }
  let(:to)    { [-104.80, 39.06546].geo_point }

  describe '#distance' do
    it "should calculate haversine distance as Float" do
      dist = GeoDistance::Haversine.distance(from, to, :units => :kms)
      dist.should be_a(Float)

      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"
      dist.kms_to(:feet).should == 24193.0
    end
  end

  describe '#geo_distance' do
    it "should calculate haversine distance as GeoDistance" do
      dist = GeoDistance::Haversine.geo_distance(from, to)
      dist.should be_a(GeoDistance)

      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"

      dist.feet.should == 24193.0
      dist.to_feet.should == 24193.0
      dist.kms.to_s.should match(/7\.376*/)
    end
  end
end
