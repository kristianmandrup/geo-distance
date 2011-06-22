require 'spec_helper'

describe GeoDistance do
  
  describe 'initialize' do
    describe 'Numeric macro' do
      it 'should create distance from number' do
        500.kms.should be_a(GeoDistance)
        500.kms.unit.should == :kms
        500.kms.units.should == :kms
        500.kms.distance.should == 500
      end
    end
  end

  context '500 kms' do
    let(:distance) { 500.kms }

    describe 'comparable' do  
      it '52 kms is less than 52500 meters' do
        52.kms.should < (52.thousand + 500.hundred).meters
      end
    end
  
    describe '#meters' do  
      it 'should be in meters' do
        distance.meters.should == 500.thousand
      end
    end

    describe '#in_meters' do  
      it 'should be in meters' do
        distance.in_meters.should == 500.thousand
      end
    end

    describe '#as_meters' do  
      it 'should be in meters' do
        distance.as_meters.should == 500.thousand
      end
    end

    describe '#as_meters!' do  
      it 'should be in meters' do
        dist = distance.as_meters!
        dist.should == distance
        dist.distance.should == 500.thousand
      end
    end

    describe '#to_meters!' do  
      it 'should be in meters' do
        dist = distance.to_meters!
        dist.should == distance
        dist.distance.should == 500.thousand
      end
    end

    describe '#feet' do
      it 'should be in feet' do
        distance.feet.should be_within(10.thousand).of(500.thousand * 3.3)
      end
    end

    describe '#to_feet' do
      it 'should return new GeoDistance converted to feet' do
        new_dist = distance.to_feet
        new_dist.should_not == distance

        new_dist.distance.should be_within(10.thousand).of(500.thousand * 3.3)
      end
    end
  end
end    
