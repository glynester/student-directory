puts "The name of this program is \"#{($0).upcase}\" which is the best name I could come up with at short notice!"
name = $0
for count in 0..3
    puts "#{name} " * count
end