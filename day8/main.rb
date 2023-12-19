REGX =  /([A-Z0-9]+) = \(([A-Z0-9]+), ([A-Z0-9]+)\)/

DIRECTION = 'LRRRLRRLLLRRRLRLRRLRRRLRLRRRLLLRRLRRLRRRLRRRLRLLRLRRLRRLLRRLRLRRRLRRLRRLRRLLRRRLRLRLRLRLLRRLLLRRLRLRRLRLLLLRRLRRRLRRLRRRLLRRRLRRLRRRLRLLRLRRLRRLLRRRLLLRLRRRLLLRRLLRRRLLRRLRRLRRLRLRRRLLRRRLRLLRLRRLLRLRRLRLLRLRRLRRRLLRRLLRRRLRRLRLRLRRRLRLRRRLRRRLRRLRRRLRLLRRRLLRRRR'


MAPS = {}
File.readlines("input.txt").each do |line|
  tmp =  line.chop.scan(REGX)[0]

  MAPS[tmp[0]] = [tmp[1], tmp[2]]
end


length = DIRECTION.size
pointer = 0
steps = 1
current_key = "AAA"

while true
  pointer = 0 if pointer >= length
  current_d = DIRECTION[pointer]

  current_hash = MAPS[current_key]

  current_key = current_hash[0]   if current_d === 'L'
  current_key = current_hash[1]   if current_d === 'R'


  break if current_key === 'ZZZ'
  p current_hash
  pointer += 1
  steps += 1
end

p "=" * 10
p "DIRECTION size: " + DIRECTION.size.to_s
p "Total Steps: " + steps.to_s
