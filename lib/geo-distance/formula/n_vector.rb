class GeoDistance
  class NVector < DistanceFormula
    def self.distance *args
      from, to, units = get_points(args)
      lat1, lon1, lat2, lon2 = [from.lat, from.lng, to.lat, to.lng]
      
      sin_x1 = Math.sin(lon1)
      cos_x1 = Math.cos(lon1)

      sin_y1 = Math.sin(lat1)
      cos_y1 = Math.cos(lat1)

      sin_x2 = Math.sin(lon2)
      cos_x2 = Math.cos(lon2)

      sin_y2 = Math.sin(lat2)
      cos_y2 = Math.cos(lat2)

      cross_prod =  (cos_y1*cos_x1 * cos_y2*cos_x2) + (cos_y1*sin_x1 * cos_y2*sin_x2) + (sin_y1 * sin_y2)
        
      c = Math.acos(cross_prod)
      
      # puts "c: #{c}"
      # radians_per_degree                          
      c = (c * 0.0201324).to_deg      
      
      units ? c.radians_to(units) : c
    end
  end
end
