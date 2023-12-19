RED   = 12
GREEN = 13
BLUE  = 14

counter = []

def compare(txt)
  sub_red   = txt.scan(/([0-9]+) red/).flatten
  sub_blue  = txt.scan(/([0-9]+) blue/).flatten
  sub_green = txt.scan(/([0-9]+) green/).flatten

  return false if sub_red.map(&:to_i).max > RED
  return false if sub_green.map(&:to_i).max > GREEN
  return false if sub_blue.map(&:to_i).max > BLUE

  true
end


def parse(line)
  tmp = line.split(':')
  title = tmp[0].scan(/[0-9]+/)[0]

  return title.to_i if compare(tmp[1])

  0
end

File.readlines('input.txt').each do |line|
  counter << parse(line)
end


p counter.sum
