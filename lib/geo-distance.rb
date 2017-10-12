require 'geo_point'

class GeoDistance
  autoload_modules :ClassMethods, :Scale, :Conversion, :Formula, :Scale, :Globe, :from => 'geo-distance'

  include GeoUnits

  include Comparable
  include Conversion

  attr_accessor :distance, :units
  attr_reader   :globe

  def initialize distance, units = :radians, options = {}
    @distance = distance
    @unit = unit_key(units)
    @globe = options[:globe] || GeoDistance.default_globe
  end

  alias_method :unit, :units

  def <=> other
     in_meters <=> other.in_meters
  end

  def number
    distance.round_to(precision[unit])
  end

  protected

  def unit_key units
    GeoUnits.key units
  end
end

require 'geo-distance/core_ext'


