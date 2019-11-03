require 'optparse'
require 'logger'

logger = Logger.new(STDOUT)

params = ARGV.getopts("", "source:", "target:", "name:")

source = params["source"]
target = params["target"]
name = params["name"]

unless Dir.exist?(source)
  logger.error("Source dir not found.")
end

unless Dir.exist?(target)
  logger.error("Target dir not found.")
end

file_path = File.join(source, name)
unless file_path.end_with?("*.png")
  file_path += "*.png"
end

files = Dir.glob(file_path)
if files.empty?
  logger.error("File not found.")
end

sizes = files.map { |file| File.size(file) }.sort

p sizes
p files.length
