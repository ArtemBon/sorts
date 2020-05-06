# quicksort
def quicksort(array, from=0, to=nil)
    if to == nil
        # Sort the whole array, by default
        to = array.count - 1
    end

    if from >= to
        # Done sorting
        return
    end

    # Take a pivot value, at the far left
    pivot = array[from]

    # Min and Max pointers
    min = from
    max = to

    # Current free slot
    free = min

    while min < max
        if free == min # Evaluate array[max]
            if array[max] <= pivot # Smaller than pivot, must move
                array[free] = array[max]
                min += 1
                free = max
            else
                max -= 1
            end
        elsif free == max # Evaluate array[min]
            if array[min] >= pivot # Bigger than pivot, must move
                array[free] = array[min]
                max -= 1
                free = min
            else
                min += 1
            end
        else
            raise "Inconsistent state"
        end
    end

    array[free] = pivot

    quicksort array, from, free - 1
    quicksort array, free + 1, to
end

# mergesort
def mergesort(array)
    if array.count <= 1
        # Array of length 1 or less is always sorted
        return array
    end

    # Apply "Divide & Conquer" strategy

    # 1. Divide
    mid = array.count / 2
    part_a = mergesort array.slice(0, mid)
    part_b = mergesort array.slice(mid, array.count - mid)

    # 2. Conquer
    array = []
    offset_a = 0
    offset_b = 0
    while offset_a < part_a.count && offset_b < part_b.count
        a = part_a[offset_a]
        b = part_b[offset_b]

        # Take the smallest of the two, and push it on our array
        if a <= b
            array << a
            offset_a += 1
        else
            array << b
            offset_b += 1
        end
    end

    # There is at least one element left in either part_a or part_b (not both)
    while offset_a < part_a.count
        array << part_a[offset_a]
        offset_a += 1
    end

    while offset_b < part_b.count
        array << part_b[offset_b]
        offset_b += 1
    end

    return array
end

# heap_sort
def heap_sort(array)  
  n = array.size  
  a = [nil] + array             # heap root [0]=>[1]  
  (n / 2).downto(1) do |i|  
    down_heap(a, i, n)  
  end  
  while n > 1  
    a[1], a[n] = a[n], a[1]  
    n -= 1  
    down_heap(a, 1, n)  
  end  
  a.drop(1)                     # heap root [1]=>[0]  
end  
  
def down_heap(a, parent, limit)  
  wk = a[parent]  
  while (child = 2 * parent) <= limit  
    child += 1  if child < limit and a[child] < a[child + 1]  
    break  if wk >= a[child]  
    a[parent] = a[child]  
    parent = child  
  end  
  a[parent] = wk  
end

# stable_sort
module Enumerable
  def stable_sort
    sort_by.with_index { |x, idx| [x, idx] }
  end

  def stable_sort_by
    sort_by.with_index { |x, idx| [yield(x), idx] }
  end
end

# introloop
class Heapsort
  def initialize(ary)
    @ary = ary.dup
    @heap_size = ary.length
  end
  def heapsort
   build_max_heap
   @ary.length.downto(2) {|i|
     swap(1, i) 
     @heap_size -= 1   
     max_heapify(1)
   }
   @ary
  end 
  def build_max_heap
    parent(@heap_size).downto(1) {|i|
      max_heapify(i)
    }
  end
  def max_heapify(i)
    l = left(i)  
    r = right(i)
    largest = (l <= @heap_size and @ary[l-1] > @ary[i-1]) ? l : i
    largest = r if (r <= @heap_size and @ary[r-1] > @ary[largest-1])
    if largest != i
      swap(i, largest)
      max_heapify(largest)
    end
  end 
  def parent(i)
    (i / 2).floor
  end
  def left(i)
    2 * i
  end
  def right(i)
    (2 * i) + 1
  end 
  def swap(i, j)
    @ary[i-1], @ary[j-1] = @ary[j-1], @ary[i-1]
  end
end
def introloop(ary, depth_limit)
  return ary if ary.size <= 1
  return Heapsort.new(ary).heapsort() if depth_limit == 0
  depth_limit -= 1
  pivot = ary.pop
  left, right = ary.partition { |e| e < pivot }
  introloop(left, depth_limit) + [pivot] + introloop(right, depth_limit)
end
def introsort(ary)
  introloop(ary, 2 * (Math.log10(ary.size) / Math.log10(2)).floor)
end
