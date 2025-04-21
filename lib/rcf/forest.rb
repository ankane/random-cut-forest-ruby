module Rcf
  class Forest
    def initialize(dimensions, shingle_size: 1, sample_size: 256, number_of_trees: 100, random_seed: 42, parallel: false)
      @dimensions = dimensions

      @pointer = FFI.rcf_create(dimensions)
      @pointer.free = FFI["rcf_free"]

      set_param("shingle_size", shingle_size)
      set_param("sample_size", sample_size)
      set_param("number_of_trees", number_of_trees)
      set_param("random_seed", random_seed)
      set_param("parallel", parallel)
    end

    def score(point)
      FFI.rcf_score(@pointer, point_ptr(point))
    end

    def update(point)
      FFI.rcf_update(@pointer, point_ptr(point))
    end

    private

    def set_param(param, value)
      if FFI.rcf_set_param(@pointer, +param, value.to_s) != 0
        raise ArgumentError, "Invalid value for #{param}"
      end
    end

    def point_ptr(point)
      if point.size != @dimensions
        raise ArgumentError, "Bad size"
      end
      Fiddle::Pointer[point.pack("f*")]
    end
  end
end
