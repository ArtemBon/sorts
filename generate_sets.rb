require 'rubystats'

sizes = [30_000, 100_000, 300_000, 1_000_000]

5.times do |version|
  sizes.each_with_index do |size, size_index|

    File.open("./sets/#{size_index+1}size_1range_#{version+1}version", "a") do |file|
      size.times { file.puts rand(2**31+1) }
    end

    File.open("./sets/#{size_index+1}size_2range_#{version+1}version", "a") do |file|
      size.times { file.puts rand(size) }
    end

    File.open("./sets/#{size_index+1}size_3range_#{version+1}version", "a") do |file|
      size.times { file.puts rand(2**15+1) }
    end

    File.open("./sets/#{size_index+1}size_4range_#{version+1}version", "a") do |file|
      gen = Rubystats::NormalDistribution.new(2**30, 100)
      file.puts gen.rng(size-1).map(&:to_i)
    end

  end
end
