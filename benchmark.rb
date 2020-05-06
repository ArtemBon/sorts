def benchmark sort, arrays
  results = []

  arrays.each do |array|
    start = Time.now
    if array.respond_to? sort.to_sym
      array.send(sort.to_sym)
    else
      send(sort.to_sym, array)
    end
    finish = Time.now
    results << finish - start
  end

  return results
end
