require 'geo_point'

class GeoDistance
  autoload :Conversion,   'geo-distance/conversion'
  autoload :Scale,        'geo-distance/scale'
  autoload :ClassMethods, 'geo-distance/class_methods'

  autoload :Haversine,    'geo-distance/formula/haversine'
  autoload :Spherical,    'geo-distance/formula/spherical'
  autoload :Vincenty,     'geo-distance/formula/vincenty'
  autoload :NVector,      'geo-distance/formula/n_vector'
  autoload :Flat,         'geo-distance/formula/flat'
end  

require 'geo-distance/distance'
require 'geo-distance/core_ext'
require 'geo-distance/formula'

