require 'sugar-high/numeric'

module GeoUnitExt
  ::GeoDistance.all_units.each do |unit|
    class_eval %{
      def #{unit}
        GeoDistance.new(self, :#{unit})
      end

      def #{unit}_to unit                           
        unit = GeoUnits.key(unit)
        send(:#{unit}).meters * GeoUnits.meters_map[unit]
      end
    }
  end

  include NumberDslExt # from sugar-high

  def rpd
    self * GeoDistance.radians_per_degree
  end  
  alias_method :to_radians, :rpd
end

class Fixnum
  include GeoUnitExt
end

class Float
  include GeoUnitExt
end
  
