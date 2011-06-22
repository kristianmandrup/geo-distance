require 'spec_helper'

describe "GeoDistance core extensions" do
  describe '#kms' do  
    it 'should convert Fixnum to GeoDistance' do
      5.kms.should be_a GeoDistance
      5.kms.distance.should == 5
      5.kms.unit.should == :kms
    end
  end

  describe '#kms' do  
    it 'should convert Float to GeoDistance' do
      5.2.kms.should be_a GeoDistance
      5.2.kms.distance.should == 5.2
      5.2.kms.unit.should == :kms
    end
  end

  describe '#meters' do  
    it 'should convert Float to GeoDistance' do
      5.2.meters.should be_a GeoDistance
      5.2.meters.distance.should == 5.2
      5.2.meters.unit.should == :meters
    end
  end

  describe '#meter' do  
    it 'should convert Float to GeoDistance' do
      2.meter.should be_a GeoDistance
      5.2.meter.distance.should == 5.2
      5.2.meter.unit.should == :meters
    end
  end

  describe '#to_radians' do  
    it 'should convert degrees to radians' do
      180.to_radians.should be_within(0.1).of 3.14159274
    end
  end
end
