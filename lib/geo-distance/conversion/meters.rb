class GeoDistance
  module Conversion
    module Meters
      def in_meters
        convert_to_meters distance
      end

      def convert_to_meters dist
        (unit == :meters) ? self.in_meters : distance / GeoUnits.meters_map[unit]
      end

      def to_meters!
        @distance = in_meters
        @unit = :meters
        self
      end 
    end
  end
end