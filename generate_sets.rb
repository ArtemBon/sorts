require 'rubystats'

sizes = [3_000, 10_000, 30_000, 100_000]

5.times do |version|
  sizes.each_with_index do |size, size_index|

    File.open("./sets/1range_#{size_index+1}size_#{version+1}version", "a") do |file|
      size.times { file.puts rand(2**31+1) }
    end

    File.open("./sets/2range_#{size_index+1}size_#{version+1}version", "a") do |file|
      size.times { file.puts rand(size) }
    end

    File.open("./sets/3range_#{size_index+1}size_#{version+1}version", "a") do |file|
      size.times { file.puts rand(2**15+1) }
    end

    File.open("./sets/4range_#{size_index+1}size_#{version+1}version", "a") do |file|
      gen = Rubystats::NormalDistribution.new(2**30, 100)
      file.puts gen.rng(size-1).map(&:to_i)
    end

  end
end
