class GeoDistance
  module Conversion
    autoload :Meters,   'geo-distance/conversion/meters'
    autoload :Radians,  'geo-distance/conversion/radians'
    
    def self.included(base)
      base.send :include, Meters
      base.send :include, Radians
    end
    
    ::GeoDistance.units.each do |unit|
      class_eval %{
        def #{unit}
          delta_#{unit}
        end
        alias_method :to_#{unit}, :#{unit}
      }
    end

    (::GeoDistance.units - [:meters]).each do |unit|
      class_eval %{
        def in_#{unit}
          dist = (unit == :radians) ? in_radians : distance            
          conv_unit = GeoUnits.key :#{unit}
          convert_to_meters(dist) * GeoUnits.meters_map[conv_unit]
        end

        def to_#{unit}!
          conv_unit = GeoUnits.key :#{unit}
          self.distance = in_meters * GeoUnits.meters_map[conv_unit]
          self.unit = conv_unit
          self
        end          
      } 
    end
    
    ::GeoDistance.all_units.each do |unit|
      class_eval %{
        def #{unit}
          un = GeoUnits.key :#{unit}
          send(:"as_\#{un}")
        end
      }
    end
    
    ::GeoDistance.units.each do |unit|
      class_eval %{
        def as_#{unit}
          in_#{unit}
        end

        def to_#{unit}
          cloned = self.dup
          un = GeoUnits.key :#{unit}
          cloned.distance = in_meters * GeoUnits.meters_map[un]
          cloned.unit = un
          cloned
        end        
      }
    end 
    
    protected

    # distance delta 
    GeoDistance.units.each do |unit|
      class_eval %{
        def delta_#{unit}
          unit = GeoUnits.key(:#{unit})
          GeoDistance.earth_radius[:#{unit}] * distance
        end
      }
    end       
  end
end