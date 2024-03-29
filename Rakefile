require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test

# ensure vendor files exist
task :ensure_vendor do
  vendor_config.fetch("platforms").each_key do |k|
    raise "Missing directory: #{k}" unless Dir.exist?("vendor/#{k}")
  end
end

Rake::Task["build"].enhance [:ensure_vendor]

def download_platform(platform)
  require "fileutils"
  require "open-uri"
  require "tmpdir"

  config = vendor_config.fetch("platforms").fetch(platform)
  url = config.fetch("url")
  sha256 = config.fetch("sha256")

  puts "Downloading #{url}..."
  contents = URI.parse(url).read

  computed_sha256 = Digest::SHA256.hexdigest(contents)
  raise "Bad hash: #{computed_sha256}" if computed_sha256 != sha256

  file = Tempfile.new(binmode: true)
  file.write(contents)

  vendor = File.expand_path("vendor", __dir__)
  FileUtils.mkdir_p(vendor)

  dest = File.join(vendor, platform)
  FileUtils.rm_r(dest) if Dir.exist?(dest)

  if url.end_with?(".tar.gz")
    FileUtils.mkdir_p(dest)
    system "tar", "xzf", file.path, "-C", dest, "--strip-components=1", exception: true
  else
    # run apt install unzip on Linux
    tmpdir = Dir.mktmpdir
    system "unzip", "-q", file.path, "-d", tmpdir, exception: true
    FileUtils.mv(Dir["#{tmpdir}/*"].first, dest)
  end

  # remove unneeded files
  FileUtils.rm_r("#{dest}/example")
  FileUtils.rm_r("#{dest}/include")
end

def vendor_config
  @vendor_config ||= begin
    require "yaml"
    YAML.safe_load(File.read("vendor.yml"))
  end
end

namespace :vendor do
  task :all do
    vendor_config.fetch("platforms").each_key do |k|
      download_platform(k)
    end
  end

  task :platform do
    if Gem.win_platform?
      download_platform("x64-mingw")
    elsif RbConfig::CONFIG["host_os"] =~ /darwin/i
      if RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
        download_platform("arm64-darwin")
      else
        download_platform("x86_64-darwin")
      end
    else
      if RbConfig::CONFIG["host_cpu"] =~ /arm|aarch64/i
        download_platform("aarch64-linux")
      else
        download_platform("x86_64-linux")
      end
    end
  end
end
