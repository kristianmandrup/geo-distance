require 'geo-distance/class_methods'

class GeoDistance
  include Comparable

  include Conversion
   
  attr_accessor :distance, :unit

  def initialize distance, unit = :kms
    @distance = distance
    @unit = GeoUnits.key(unit)
  end

  alias_method :units, :unit

  def <=> other
     in_meters <=> other.in_meters
  end

  def number
    distance.round_to(precision[unit])
  end
end
