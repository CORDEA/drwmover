require 'optparse'

params = ARGV.getopts("", "source:", "target:")
p params
