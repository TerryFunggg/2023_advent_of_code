#Card  Match     Copies                            Instance
#1         4 -> (2,3,4,5)                                1
#2         2 -> (3,4),(3,4)                              2
#3         2 -> (4,5),(4,5),(4,5),(4,5)                  4
#4         1 -> (5),(5),(5),(5),(5),(5),(5),(5)          8
#5         0 -> []                                      14
#6         0 -> []                                       1
#
#
#Total = 30
COPIES = []
INSTANCE =[]

File.readlines('input.txt').each do |line|
  tmp = line.chop.split(':')
  head = tmp[0].scan(/[0-9]+/)[0].to_i
  tail = tmp[1].split('|')

  card_nums = tail[0].scan /[0-9]+/
  guess_nums = tail[1].scan /[0-9]+/

  match = (card_nums & guess_nums).count

  acc = head
  tmp = []
  while acc <= match + head - 1
    acc = acc + 1
    tmp << acc
  end
  
  num = COPIES.flatten.count(head)
  tmp = tmp + (tmp * num)

  COPIES << tmp

  INSTANCE << (COPIES.flatten.count(head) + 1)
end


p INSTANCE.sum
