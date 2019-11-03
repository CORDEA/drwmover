require 'optparse'
require 'logger'

logger = Logger.new(STDOUT)

params = ARGV.getopts("", "source:", "target:")
source = params["source"]
target = params["target"]

unless Dir.exist?(source)
  logger.error("Source dir not found.")
end

unless Dir.exist?(target)
  logger.error("Target dir not found.")
end
