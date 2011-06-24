class GeoDistance
  module Formula
    class NVector < Abstract
      def initialize globe = nil
        super
      end

      def distance *args
        from, to, units = get_points(args)
        [from, to].to_radians!
      
        sin_x1 = Math.sin from.lng
        cos_x1 = Math.cos from.lng

        sin_y1 = Math.sin from.lat
        cos_y1 = Math.cos from.lat

        sin_x2 = Math.sin to.lon
        cos_x2 = Math.cos to.lon

        sin_y2 = Math.sin to.lat2
        cos_y2 = Math.cos to.lat2

        cross_prod =  (cos_y1*cos_x1 * cos_y2*cos_x2) + (cos_y1*sin_x1 * cos_y2*sin_x2) + (sin_y1 * sin_y2)

        c = if (cross_prod >= 1 || cross_prod <= -1)
          cross_prod > 0 ? 0 : PI         
        else 
          Math.acos(cross_prod)
        end.to_deg
      
        units ? c.radians_to(units) : c
      end
    end
  end
end