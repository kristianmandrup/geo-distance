require 'geo_point'

class GeoDistance
  autoload_modules :ClassMethods, :Scale, :Conversion, :Globe, :from => 'geo_distance'
end  

require 'geo-distance/distance'
require 'geo-distance/core_ext'
require 'geo-distance/formula'

