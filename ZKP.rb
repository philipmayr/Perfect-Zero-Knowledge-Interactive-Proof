# Zero-Knowledge Proof

n = 80

p = 7
q = 37

N = p * q

puts "N: " + N.to_s

y = 65
x = 8

# the prover seeks to show that y is a square modulo N
# x² ≡ y (mod N)

n.times do
    # prover:
    
    r = 22 % N
    
    puts "r: " + r.to_s
    
    s = (r * r) % N
    
    puts "s: " + s.to_s

    # verifier:
    
    β = rand(2)
    
    puts "β: " + β.to_s
    
    # prover:
    
    if β == 0
        z = r % N
    elsif β == 1
        z = (x * r) % N
    end
    
    puts "z: " + z.to_s
    
    # verifier:

    z² = (z * z) % N
    
    if β == 0
        if z² == s % N
            puts ">: proof accepted (β = 0)"
        elsif
            puts ">: proof rejected (β = 0)"
        end
    elsif β == 1
        if z² == (y * s) % N
            puts ">: proof accepted (β = 1)"
         elsif
            puts ">: proof rejected (β = 1)"
        end
    end
    
    puts
end
