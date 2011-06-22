require 'spec_helper'

describe GeoDistance::Flat do
  let(:from)  { [-104.88544, 39.06546].geo_point }
  let(:to)    { [-104.80, 39.06546].geo_point }

  describe '#distance' do
    it "should calculate flat distance as Float" do
      dist = GeoDistance::Flat.distance(from, to)
      dist.should be_a(Float)

      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"
      dist.to_feet.should == 24193.0
    end
  end

  describe '#geo_distance' do
    it "should calculate haversine distance as GeoDistance" do
      dist = GeoDistance::Flat.geo_distance(from, to)
      dist.should be_a(GeoDistance)

      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"

      dist.feet.should == 24193.0
      dist.to_feet.should == 24193.0
      dist.kms.to_s.should match(/7\.376*/)
    end
  end
end