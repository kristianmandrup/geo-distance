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
        self.units = :meters
        self
      end
      alias_method :in_meters!, :to_meters!
      alias_method :as_meters!, :to_meters!

      def convert_to_meters dist
        (units == :meters) ? dist : distance / GeoUnits::Maps::Meters.to_unit_multiplier[units]
      end

      def to_meters!
        @distance = in_meters
        @units = :meters
        self
      end 
    end
  end
end