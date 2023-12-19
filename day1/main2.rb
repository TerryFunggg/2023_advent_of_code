counter = []

class String
  #include EnglishNumber
  @@num_h = {
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9
  }

  def to_i

    return @@num_h[self.to_sym] if @@num_h.key? self.to_sym

    Integer(self)
  end
end

REGX = /(?=([0-9]|one|two|three|four|five|six|seven|eight|nine))/

def scan(line)
  line = line.to_s
  nums = line.scan(REGX)

  return 0 if nums.count == "0"
  return "#{nums.first.to_i}#{nums.first.to_i}" if nums.count == 1

  "#{nums.first.to_i}#{nums.last.to_i}"
end


File.readlines('input.txt').each do |line|
  counter << scan(line)
end

p counter.sum(&:to_i)
