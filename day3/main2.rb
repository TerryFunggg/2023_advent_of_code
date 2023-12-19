NUMBER = /[0-9]/
DOT = /[.]/
SYMBOL = /[\$|\/|\*|\+|\=|\&|\%|\#|\@|\-]/
MAP = []
SYMBOL_LIST = []
MARK = []
WORD_LIST =[]

class Node
  attr_accessor :row, :column, :value
  attr_accessor :left, :right

  def initialize(row, column, value)
    @row = row
    @column = column
    @value = value
  end

  def left_word(node)
    return '' if node.nil?

    word = left_word(node.left)

    MARK << node
    word + node.value
  end

  def right_word(node)
    return '' if node.nil?

    word = right_word(node.right)

    MARK << node
    node.value + word
  end

  def to_w
    l = left_word(left)
    r = right_word(right)

    MARK << self
    l + value + r
  end
end



File.readlines('input.txt').each.with_index do | line, row |
  tmp = []
  line.scan(/./).each.with_index do |item, column|
    node =  Node.new(row, column, item)

    tmp << node
    SYMBOL_LIST << node if item =~ SYMBOL

  end

  tmp.each.with_index do |node, index|
    if index == 0
      node.right = tmp[index + 1] if tmp[index + 1].value =~ NUMBER
    elsif index == tmp.count - 1
      node.left = tmp[index - 1] if tmp[index - 1].value =~ NUMBER
    else
      node.right = tmp[index + 1] if tmp[index + 1].value =~ NUMBER
      node.left = tmp[index - 1] if tmp[index - 1].value =~ NUMBER
    end
  end

  MAP << tmp

end

TOTAL_COLUMN = MAP[0].count
TOTAL_ROW = MAP.count

sym = SYMBOL_LIST[0]

def scan(node)
  col = node.column
  row = node.row

  left   = MAP[row][col - 1]
  right  = MAP[row][col + 1]
  top    = MAP[row - 1][col]
  bottom = MAP[row + 1][col]
  top_left = MAP[row - 1][col - 1]
  top_right = MAP[row - 1][col + 1]
  bottom_left= MAP[row + 1][col - 1]
  bottom_right = MAP[row + 1][col + 1]

  direcitons = [left,right,top,bottom, top_left, top_right, bottom_left, bottom_right]

  direcitons.map do | n |
    if n.value =~ NUMBER
      WORD_LIST << n.to_w unless MARK.include? n
    end

  end

end


SYMBOL_LIST.each {|s| scan s}

p WORD_LIST.map(&:to_i).sum
