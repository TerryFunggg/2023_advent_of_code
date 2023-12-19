class Node
  attr_accessor :x, :y, :value

  def initialize(x, y, value)
    @x = x
    @y = y
    @value = value
  end

  def to(node)
    [(node.x - self.x).abs, (node.y - self.y).abs].sum
  end
end

tmp = []
slash = 1
slash_arr = []
File.readlines('input.txt').each.with_index do |line, row|
  line = line.chop.scan(/./)
  line.each.with_index do |item, col|
    if item == '#'
      slash_arr << Node.new(col, row, slash.to_s)
      slash += 1
    end
  end
  tmp << line
end

def get_conv(tmp)
  tmp_num = 0
  tmp.map do | item | 
    tmp_num += 1000000 - 1 if item.uniq.count == 1
    tmp_num
  end
end

y_conv = get_conv tmp
# column -> row, row -> column
x_conv = get_conv tmp.transpose

# expanded value
slash_arr.each do |item|
  item.x = item.x + x_conv[item.x]
  item.y = item.y + y_conv[item.y]
end

result = []
(slash_arr.count - 1).downto(1) do |item|
  head = slash_arr.shift

  find_node_to_node_dist = proc {|nodes| nodes[0].to nodes[1]}
  
  dists = [head].product(slash_arr).map(&find_node_to_node_dist)

  result.push(dists.sum)
end

p result.sum
