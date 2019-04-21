N = 4096

def sum_by_row(m)
  t1 = Time.now
  s = 0.0
  for row in 0 ... N do
    for col in 0 ... N do
      s += m[row*N + col]
    end
  end
  t2 = Time.now
  puts "sum_by_row (#{s}): #{1e6*(t2-t1)} micro-seconds"
end

def sum_by_col(m)
  t1 = Time.now
  s = 0.0
  for row in 0 ... N do
    for col in 0 ... N do
      s += m[row + col*N]
    end
  end
  t2 = Time.now
  puts "sum_by_col (#{s}): #{1e6*(t2-t1)} micro-seconds"
end

t1 = Time.now
m = [0] * (N*N)
for i in 0 ... N*N do
  m[i] = i % 2
end
t2 = Time.now
puts "init_matrix: #{1e6*(t2-t1)} micro-seconds"

for c in ARGV[0].each_char do
  case c
  when 'r'
    sum_by_row(m)
  when 'c'
    sum_by_col(m)
  end
end
