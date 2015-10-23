require 'rubygems'
require 'colorize'

class DependencyAnalysis
  def initialize
    @pattern = /^(~>|>=|<)/
    @hash = {}
  end

  def parse(args)
    args.each do |arg|
      @parameter = ''
      abort('No correct parameter in arg'.red) if arg.match(@pattern).nil?
      @parameter = arg.match(@pattern)[0]
      @version = arg[@parameter.length + 1..arg.length - 1]
      abort('Incorrect version'.red) unless Gem::Version.correct?(@version)
      @hash[@parameter] = @version
    end

    unless @hash.size == args.size
      abort('Avoid duplicated dependencies and both pessimistic constraints'.red)
    end
    @hash
  end
end
