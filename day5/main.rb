#SEEDS =[ 564468486,226119074,3264322485,135071952,3144185610,89794463,1560365167,555667043,2419038624,7808461,1264209624,9380035,105823719,425973940,4115473551,104486997,3784956593,300187503,975280918,257129208]

#SEEDS =[564468486]


SEEDS = [79,14,55,13]


FILES_NAMES = [
'seed-to-soil',
'soil-to-fertilizer',
#'fertilizer-to-water',
#'water-to-light',
#'light-to-temperature',
#'temperature-to-humidity',
#'humidity-to-location'
]

FILES_NAMES.each do |fname|
  p fname

  maps = []
  File.readlines("#{fname}.txt").each do |line|

    nums = line.chop.split(' ')

    dest = nums[0].to_i
    source = nums[1].to_i
    range = nums[2].to_i - 1
    max_source  = source + range


    source_list = source.upto(source + range - 1)
    dest_list = dest.upto(dest + range - 1)

    tmp = []
    tmp << source_list
    tmp << dest_list

    maps << tmp
  end

  SEEDS.each.with_index do | seed, seed_index |
    maps.each.with_index do |map, row|
      if map[0].member?(seed)


        new_sourcs_pos = ((map[0].min)..seed).count

        d_min = map[1].min

        dest = d_min.upto(d_min + new_sourcs_pos - 1).max

        SEEDS[seed_index] = dest
        break
      end

    end
  end

  p SEEDS
end


p "The lowest location number: " + SEEDS.min.to_s
