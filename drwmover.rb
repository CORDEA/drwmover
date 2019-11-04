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
  logger.error("Source dir not found.")
end

unless Dir.exist?(target)
  logger.error("Target dir not found.")
end

files = Dir.glob(File.join(source, name + "*.png"))
if files.empty?
  logger.error("File not found.")
end

if files.length < 5
  logger.error("Drawable file is not enough.")
end

files.sort_by! { |file| File.size(file) }
paths = DPI.map { |dpi| File.join(target, DRAWABLE_PATH + "-" + dpi) }

paths.each { |path|
  unless Dir.exist?(path)
    logger.error("Drawable dir not found.")
  end
}

p sizes
p files.length
