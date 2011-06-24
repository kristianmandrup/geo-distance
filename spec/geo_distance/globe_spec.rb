# require 'spec_helper'
# 
# class Norma
#   include GeoUnits::Converter::Normalizer
# end
# 
# def norma
#   Norma.new
# end
# 
# describe GeoUnits::Converter::Normalizer do
#   describe '#degrees_to_radians' do
#     it 'should normalize to within: -90 and 90' do
#       lat = norma.normalize_lat -91
#       lat.should be_a(Float)
#       lat.should == 1
#     end
#   end
# 
#   describe '#units_sphere_multiplier' do
#     it 'should normalize to within: -90 and 90' do
#       lat = norma.normalize_lat -91
#       lat.should be_a(Float)
#       lat.should == 1
#     end
#   end
# 
#   describe '#units_per_latitude_degree' do
#     it 'should normalize to within: -90 and 90' do
#       lat = norma.normalize_lat -91
#       lat.should be_a(Float)
#       lat.should == 1
#     end
#   end
# 
#   describe '#units_per_longitude_degree' do
#     it 'should normalize to within: -90 and 90' do
#       lat = norma.normalize_lat -91
#       lat.should be_a(Float)
#       lat.should == 1
#     end
#   end
# 
#   describe '#degrees_to_radians' do
#     it 'should normalize to within: -90 and 90' do
#       lat = norma.normalize_lat -91
#       lat.should be_a(Float)
#       lat.should == 1
#     end
#   end
# end

# def degrees_to_radians(degrees)   
#   degrees.to_f * GeoUnits::Constants.radians_per_degree
# end
# 
# def units_sphere_multiplier(units)
#   units = GeoUnits.key units
#   GeoUnits::Mapsearth_radius_map[units]
# end
# 
# def units_per_latitude_degree(units)
#   units = GeoUnits.key units
#   GeoUnits::Maps.radian_multiplier[units]
# end
# 
# def units_per_longitude_degree(lat, units)
#   miles_per_longitude_degree = (latitude_degrees * Math.cos(lat * pi_div_rad)).abs 
#   units = GeoUnits.key units
#   miles_per_longitude_degree.miles_to(units)
# end 
# 
# 
# def radians_ratio units
