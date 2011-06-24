require 'geo-distance/core_ext'
require 'geo-distance/formula'

class GeoDistance
  class Vincenty < DistanceFormula
    def initialize options = {}
      super
    end

    # Calculate the distance between two Locations using the Vincenty formula
    #
    def distance *args
      begin
        from, to, units = get_points(args)        
        lat1, lon1, lat2, lon2 = [from.lat, from.lng, to.lat, to.lng].map{|deg| deg.rpd }
            
        f = (globe_major_axis_radius_kms - globe_minor_axis_radius_kms) / globe_major_axis_radius_kms

        l = lon2 - lon1
        u1 = atan((1-f) * tan(lat1))
        u2 = atan((1-f) * tan(lat2))
        sin_u1 = sin(u1)
        cos_u1 = cos(u1)
        sin_u2 = sin(u2)
        cos_u2 = cos(u2)

        lambda = l
        lambda_p = 2 * PI
        iteration_limit = 20
        while (lambda-lambda_p).abs > 1e-12 && (iteration_limit -= 1) > 0
          sin_lambda = sin(lambda)
          cos_lambda = cos(lambda)
          sin_sigma = sqrt((cos_u2*sin_lambda) * (cos_u2*sin_lambda) + 
            (cos_u1*sin_u2-sin_u1*cos_u2*cos_lambda) * (cos_u1*sin_u2-sin_u1*cos_u2*cos_lambda))
          return 0 if sin_sigma == 0  # co-incident points
          cos_sigma = sin_u1*sin_u2 + cos_u1*cos_u2*cos_lambda
          sigma = atan2(sin_sigma, cos_sigma)
          sin_alpha = cos_u1 * cos_u2 * sin_lambda / sin_sigma
          cosSqAlpha = 1 - sin_alpha*sin_alpha
          cos2SigmaM = cos_sigma - 2*sin_u1*sin_u2/cosSqAlpha

          cos2SigmaM = 0 if cos2SigmaM.nan?  # equatorial line: cosSqAlpha=0 (§6)

          c = f/16*cosSqAlpha*(4+f*(4-3*cosSqAlpha))
          lambda_p = lambda
          lambda = l + (1-c) * f * sin_alpha *
            (sigma + c*sin_sigma*(cos2SigmaM+c*cos_sigma*(-1+2*cos2SigmaM*cos2SigmaM)))
       end
       # formula failed to converge (happens on antipodal points)
       # We'll call Haversine formula instead.
       return Haversine.distance(from, to, units) if iteration_limit == 0 

       uSq = cosSqAlpha * (globe_major_axis_radius_kms**2 - globe_minor_axis_radius_kms**2) / (globe_minor_axis_radius_kms**2)
       a = 1 + uSq/16384*(4096+uSq*(-768+uSq*(320-175*uSq)))
       b = uSq/1024 * (256+uSq*(-128+uSq*(74-47*uSq)))
       delta_sigma = b*sin_sigma*(cos2SigmaM+b/4*(cos_sigma*(-1+2*cos2SigmaM*cos2SigmaM)-
         b/6*cos2SigmaM*(-3+4*sin_sigma*sin_sigma)*(-3+4*cos2SigmaM*cos2SigmaM)))
     
        c = globe_minor_axis_radius_kms * a * (sigma-delta_sigma)

        c = (c / unkilometer).to_deg

        units ? c.radians_to(units) : c
      rescue Errno::EDOM
        0.0
      end
    end

    private
    
    def self.unkilometer    
      6378.135
    end      
  end
end