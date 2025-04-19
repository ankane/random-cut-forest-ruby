# stdlib
require "fiddle/import"

# modules
require_relative "rcf/forest"
require_relative "rcf/version"

module Rcf
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end
  lib_path =
    if Gem.win_platform?
      "x64-mingw/lib/rcf.dll"
    elsif RbConfig::CONFIG["host_os"] =~ /darwin/i
      if RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
        "arm64-darwin/lib/librcf.dylib"
      else
        "x86_64-darwin/lib/librcf.dylib"
      end
    else
      if RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
        "aarch64-linux/lib/librcf.so"
      else
        "x86_64-linux/lib/librcf.so"
      end
    end
  vendor_lib = File.expand_path("../vendor/#{lib_path}", __dir__)
  self.ffi_lib = [vendor_lib]

  # friendlier error message
  autoload :FFI, "rcf/ffi"
end
