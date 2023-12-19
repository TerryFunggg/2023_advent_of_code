require 'byebug'


def get_seq(line)
   line.each_cons(2).map do |item|
    item = item[1] - item[0]
  end
end

def recursive(line)
  return 0 if line.uniq.count == 1 && line.last == 0

  seq = get_seq line

  new_value = seq.first - recursive(seq)
end


sum = 0
File.readlines('input.txt').each do |line|
  line = line.chop.split(" ").map(&:to_i)
  p line
  next_value = line.first - recursive(line)
  sum += next_value
end

p sum
