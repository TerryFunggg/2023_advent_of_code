REGX =  /([A-Z0-9]+) = \(([A-Z0-9]+), ([A-Z0-9]+)\)/

DIRECTION = 'LRRRLRRLLLRRRLRLRRLRRRLRLRRRLLLRRLRRLRRRLRRRLRLLRLRRLRRLLRRLRLRRRLRRLRRLRRLLRRRLRLRLRLRLLRRLLLRRLRLRRLRLLLLRRLRRRLRRLRRRLLRRRLRRLRRRLRLLRLRRLRRLLRRRLLLRLRRRLLLRRLLRRRLLRRLRRLRRLRLRRRLLRRRLRLLRLRRLLRLRRLRLLRLRRLRRRLLRRLLRRRLRRLRLRLRRRLRLRRRLRRRLRRLRRRLRLLRRRLLRRRR'

MAPS = {}

File.readlines("input.txt").each do |line|
  tmp =  line.chop.scan(REGX)[0]

  MAPS[tmp[0]] = [tmp[1], tmp[2]]
end

def get_step_to_z(label)
  length = DIRECTION.size
  pointer = 0
  steps = 1
  current_key = label

  while true
      pointer = 0 if pointer >= length
      current_d = DIRECTION[pointer]

      current_hash = MAPS[current_key]

      current_key = current_hash[0]   if current_d === 'L'
      current_key = current_hash[1]   if current_d === 'R'


    break if current_key[2] === 'Z'

    pointer += 1
    steps += 1
  end

  return steps
end


list = [
  'AAA',
  'VLA',
  "PJA",
  "VSA",
  "QKA",
  "CPA"
].to_h {|k,i| [k,0]}

steps_list = []
list.each do |k,i|
  steps_list << get_step_to_z(k)
end

p steps_list.reduce(1, :lcm)
