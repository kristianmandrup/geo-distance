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

  context '500 kms' do
    let(:distance) { 500.kms }
  
    describe 'meters' do  
      distance.meters.should == 500.thousand
    end

    describe 'feet' do
      distance.feet.should be_witin(5000).of(500.thousand * 3.3)
    end

    describe 'to_feet' do
      distance.to_feet.should be_witin(5000).of(500.thousand * 3.3)
    end
  end
end    
