require 'fileutils'
require 'optparse'
require 'logger'

DPI = %w(mdpi hdpi xhdpi xxhdpi xxxhdpi)
DRAWABLE_PATH = "src/main/res/drawable"
SUFFIX = ".png"

logger = Logger.new(STDOUT)

params = ARGV.getopts("", "source:", "target:", "name:")

source = params["source"]
target = params["target"]
name = params["name"]
file_name = name + SUFFIX

unless Dir.exist?(source)
  logger.fatal("Source dir not found.")
  exit(1)
end

unless Dir.exist?(target)
  logger.fatal("Target dir not found.")
  exit(1)
end

files = Dir.glob(File.join(source, name + "*.png"))
if files.empty?
  logger.fatal("File not found.")
  exit(1)
end

if files.length < 5
  logger.fatal("Drawable file is not enough.")
  exit(1)
end

files.sort_by! { |file| File.size(file) }
paths = DPI.map { |dpi| File.join(target, DRAWABLE_PATH + "-" + dpi) }

paths.each { |path|
  unless Dir.exist?(path)
    logger.warn("Drawable dir not found.")
  end
}

files.zip(paths).each { |file, path|
  FileUtils.cp(file, File.join(path, file_name), verbose: true)
}
