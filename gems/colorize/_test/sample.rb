# rbs_inline: enabled

require "colorize"

class ColorizeSample
  #: (String) -> String
  def colorized_hello(name)
    "Hello, #{name}!".colorize(:green)
  end

  #: (Integer, Integer) -> String
  def colorized_sum(a, b)
    "#{a} + #{b} = #{a + b}".colorize(:blue)
  end
end

sample = ColorizeSample.new
puts sample.colorized_hello("World")
puts sample.colorized_sum(1, 2)
