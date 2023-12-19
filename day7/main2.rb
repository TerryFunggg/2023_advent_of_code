LABELS = {'2' => 2 ,'3'=>3,'4'=>4,'5'=>5,'6'=>6,'7'=>7,'8'=>8,'9'=>9,'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}

def compare(c1, c2)
  c1.chars.each.with_index do |c,index|
    return 1  if  LABELS[c] > LABELS[c2[index]]
    return -1 if  LABELS[c] < LABELS[c2[index]]
  end

  0
end

def get_type(card)
  card = card.chars

  tmp = {}
  card.each do |c|
    if tmp[c].nil?
      tmp[c] = 1
    else
    tmp[c] += 1
    end
  end

  tmp = tmp.values

  return 7 if tmp.max == 5
  return 6 if tmp.max == 4
  return 5 if tmp.max == 3 && tmp.min == 2
  return 4 if tmp.max == 3
  return 3 if tmp.max == 2 && tmp.count == 3
  return 2 if tmp.max == 2 && tmp.count == 4

  tmp =  LABELS.keys.map(&:to_s)
  head = tmp.index(card[0])
  (head..(card.count - 1)).each  do |index|
    return 0 if tmp[index] != card[index]
  end

1
end

DATA = []
CARDS = [] 
RANKS = {}
File.readlines('input.txt').each do |line|
  tmp = line.chop.split(" ")
  DATA << tmp
  CARDS << tmp[0]
end

CARDS.each.with_index do |card, index|
  type = get_type(card).to_s
  if RANKS[type].nil?
    RANKS[type] = [card]
  else
    tmp = RANKS[type] 
    tmp << card
    tmp = tmp.sort {|a,b| compare(a,b)}
    RANKS[type] = tmp
  end
end


list =  RANKS.sort_by {|i| i[0]}
list =  list.transpose[1].flatten
DATA_DIC = DATA.to_h {|item| [item[0], item[1]]}

SUM = []

list.each.with_index do |item, index|
  bid = DATA_DIC[item].to_i
  rank = index + 1
  p "#{item}, #{index}, #{bid}"
  SUM << (bid*rank)
end

p SUM.sum
