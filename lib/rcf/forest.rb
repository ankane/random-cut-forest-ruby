module Rcf
  class Forest
    def initialize(dimensions)
      @dimensions = dimensions
      @pointer = FFI.rcf_create(dimensions)

      ObjectSpace.define_finalizer(self, self.class.finalize(@pointer))
    end

    def score(point)
      FFI.rcf_score(@pointer, point_ptr(point))
    end

    def update(point)
      FFI.rcf_update(@pointer, point_ptr(point))
    end

    def self.finalize(pointer)
      # must use proc instead of stabby lambda
      proc { FFI.rcf_free(pointer) }
    end

    private

    def point_ptr(point)
      if point.size != @dimensions
        raise ArgumentError, "Bad size"
      end
      Fiddle::Pointer[point.pack("f*")]
    end
  end
end
