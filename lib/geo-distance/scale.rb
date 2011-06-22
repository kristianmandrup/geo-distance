class GeoDistance
  module Scale
    def * arg
      multiply arg
    end

    def / arg
      multiply(1.0/arg)
      self
    end

    def multiply arg
      check_numeric! arg
      self.distance *= arg
      self
    end
  end
end