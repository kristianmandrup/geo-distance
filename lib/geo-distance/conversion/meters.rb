class GeoDistance
  module Conversion
    module Meters
      def in_meters
        convert_to_meters distance
      end
      alias_method :to_meters, :in_meters
      alias_method :as_meters, :in_meters

      def to_meters!
        self.distance = convert_to_meters distance
        self.unit = :meters
        self
      end
      alias_method :in_meters!, :to_meters!
      alias_method :as_meters!, :to_meters!

      def convert_to_meters dist
        (unit == :meters) ? dist : distance / GeoUnits.meters_map[unit]
      end

      def to_meters!
        @distance = in_meters
        @unit = :meters
        self
      end 
    end
  end
end