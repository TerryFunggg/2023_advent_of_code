counter = []

def scan(line)
  line = line.to_s
  nums = line.scan /[0-9]/
  return "0" if nums.count == 0

  "#{nums.first}#{nums.last}"
end

File.readlines('input.txt').each do |line|
  counter << scan(line)
end

p counter.sum(&:to_i)
