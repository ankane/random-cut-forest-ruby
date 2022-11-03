module Rcf
  module FFI
    extend Fiddle::Importer

    libs = Rcf.ffi_lib.dup
    begin
      dlload Fiddle.dlopen(libs.shift)
    rescue Fiddle::DLError => e
      retry if libs.any?
      raise e
    end

    extern "rcf_forest *rcf_create(size_t dimensions)"
    extern "void rcf_update(rcf_forest *rcf, const float *point)"
    extern "double rcf_score(rcf_forest *rcf, const float *point)"
    extern "void rcf_free(rcf_forest *rcf)"
  end
end
