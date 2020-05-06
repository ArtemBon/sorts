require './sorts.rb'
require './benchmark.rb'

ranges = [
          'evenly distributed random numbers from 0 to 2^31',
          'evenly distributed random numbers from 0 to N-1',
          'evenly distributed random numbers from 0 to 2^15',
          'normal distributed random numbers from 0 to 2^31'
         ]
sizes = [3_000, 10_000, 30_000, 100_000]
sorts = ['sort', 'stable_sort', 'quicksort', 'mergesort', 'heap_sort', 'introsort']

ranges.each_with_index do |range, range_index|
  sizes.each_with_index do |size, size_index|
    sorts.each do |sort|

      versions = []

      (1..5).each do |version_index|
        File.open("./sets/#{range_index+1}range_#{size_index+1}size_#{version_index}version", "r") do |file|
          array = []

          while line = file.gets
            unless line.empty?
              array << line.to_i
            end
          end

          versions << array
        end
      end

      results = benchmark(sort, versions)
      avarage_time = results.inject(0.0) { |sum, el| sum + el } / results.size

      puts " An #{size}\tsize array of #{range}\thas been sorted  with #{sort}      \tin an average  of #{avarage_time.round(9)}\tseconds"
    
    end
  end
end
