# part 2 same code below

DATA = [
  [53897698,313109012141201],

]

#
#press    1          2          3          4         5
#remaing  6          5          4          3         2
#per ms   1          2          3          4         5
#dist     6ms        10ms      12ms       12ms      10ms
#
#
#    remaing * press#
total  = 1

DATA.each do |race|
  time = race[0]
  record = race[1]

  win = []

  1.upto(time) do |t|
    remaing = time - t

    dist = remaing * t

    win << dist if dist > record
  end

  total = total * win.count
end

p total
