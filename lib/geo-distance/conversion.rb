class GeoDistance
  module Conversion
    autoload :Meters,   'geo-distance/conversion/meters'
    autoload :Radians,  'geo-distance/conversion/radians'
    
    def self.included(base)
      base.send :include, Meters
      base.send :include, Radians
    end

    def from_units(units)
      GeoUnits::Maps::Meters.from_unit_multiplier[units]
    end

    def to_units(units)
      GeoUnits::Maps::Meters.to_unit_multiplier[units]
    end

    def unit_key units
      GeoUnits.key units
    end
    
    # return new GeoDistance instance with distance converted to specific unit
    ::GeoDistance.units.each do |unit|
      class_eval %{
        def to_#{unit}
          cloned = self.dup
          un = unit_key :#{unit}
          cloned.distance = in_meters * to_units(un)
          cloned.unit = un
          cloned
        end
      }
    end

    # in_ and as_ return distance as a Float
    # to_xxx! and similar, modify distance (self) directly
    (::GeoDistance.units - [:meters]).each do |unit|
      class_eval %{
        def in_#{unit}
          dist = (unit == :radians) ? in_radians : distance            
          conv_unit = unit_key :#{unit}
          convert_to_meters(dist) * to_units(conv_unit)
        end
        alias_method :as_#{unit}, :in_#{unit}

        def to_#{unit}!
          conv_unit = unit_key :#{unit}
          self.distance = in_meters * to_units(conv_unit)
          self.unit = conv_unit
          self
        end
        alias_method :in_#{unit}!, :to_#{unit}!
        alias_method :as_#{unit}!, :to_#{unit}!
      } 
    end
    
    ::GeoDistance.all_units.each do |unit|
      class_eval %{
        def #{unit}
          un = unit_key :#{unit}
          send(:"as_\#{un}")
        end
      }
    end
  end
end