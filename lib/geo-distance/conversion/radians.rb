class GeoDistance
  module Conversion
    module Radians
      def to_radians
        cloned = self.dup               
        cloned.distance = in_radians
        cloned.unit = :radians
        cloned
      end        

      def to_radians! lat = 0
        @distance = in_radians(lat)
        @unit = :radians
      end        

      def radians_conversion_factor 
        unit.radians_ratio
      end

      # calculate the distance in radians for the given latitude
      def in_radians lat = 0
        (unit != :radians) ? distance.to_f / globe_lat_factor(lat) : distance # radians_conversion_factor
      end

      protected
      
      def globe_lat_factor u = nil, lat = 0
        (GeoDistance.globe_radius[u ||= unit] / 180) * latitude_factor(lat)
      end      
      
      def latitude_factor latitude = 0
        90 / (90 - latitude)
      end      
    end
  end
end