def sum x
end

points = []
File.readlines('input.txt').each do |line|
  tmp = line.chop.split(':')
  head = tmp[0]
  tail = tmp[1].split('|')

  winning = tail[0].scan /[0-9]+/
  nyh = tail[1].scan /[0-9]+/

  r =  (nyh & winning).count


  if r > 0
    r = r - 1
    r = 2 ** r
    points << r
  end

end



p points.sum

