require 'spec_helper'

GeoPoint.coord_mode = :lng_lat

describe "GeoDistance class methods" do
  describe '#earth_radius' do
    it 'should return in kms' do
      GeoDistance.earth_radius(:kms).should be_between(6371, 6380)
    end

    it 'should return in meters' do
      GeoDistance.earth_radius(:meters).should be_between(6371000, 6380000)
    end
  end

  describe '#radians_ratio unit' do
    it 'should return in kms' do
      puts GeoDistance.radians_ratio unit(:kms) #.should be_between(6371, 6380)
    end

    it 'should return in meters' do
      puts GeoDistance.radians_ratio unit(:meters) #.should be_between(6371000, 6380000)
    end
  end
  
  describe '#default_algorithm' do
    let(:from)  { [-104.88544, 39.06546].geo_point }
    let(:to)    { [-104.80, 39.06546].geo_point }

    it "should NOT set it to :haver" do
      lambda { GeoDistance.default_algorithm = :haver}.should raise_error
    end

    it "should set it to :haversine" do
      GeoDistance.default_algorithm = :haversine

      dist = GeoDistance.geo_distance(from, to)

      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"

      dist.feet.should == 24193.0
      dist.to_feet.should == 24193.0
      dist.kms.to_s.should match(/7\.376*/)
    end

    it "should set it to :flat" do
      GeoDistance.default_algorithm = :flat

      dist = GeoDistance.geo_distance(from, to)
      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"
      dist.feet.should be_between(23500, 25000)
    end

    it "should set it to :sphere" do
      GeoDistance.default_algorithm = :sphere

      dist = GeoDistance.geo_distance(from, to)
      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"
      dist.feet.should be_between(23500, 25000)
    end

    it "should set it to :vincenty" do
      GeoDistance.default_algorithm = :vincenty

      dist = GeoDistance.geo_distance(from, to)
      puts "the distance from #{from} to #{to} is: #{dist.meters} meters"
      dist.feet.should be_between(23500, 25000)
    end
  end
end
