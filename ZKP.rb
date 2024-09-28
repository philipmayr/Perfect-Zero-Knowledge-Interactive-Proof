# Perfect Zero-Knowledge Proof

# get two primes
print "Enter first prime number: "
p = gets.chomp.to_i
print "Enter second prime number: "
q = gets.chomp.to_i

# product of the two primes
N = p * q

puts

puts "N = " + N.to_s + " (" + p.to_s + " ⋅ " + q.to_s + ")"

puts

# square modulo N
print "Enter a square number modulo " + N.to_s + ": "
y = gets.chomp.to_i
# square root of square modulo N
x = Math.sqrt(y)

# the prover seeks to show that y is a square modulo N
# x² ≡ y (mod N)

puts

# number of challenge-response rounds
print "Enter number of challenge-response rounds: "
n = gets.chomp.to_i

puts

# number of proofs accepted
proof_accepted_counter = 0

n.times do |iteration|
    puts ">: Round " + (iteration + 1).to_s
    
    # prover:
    
    # random number
    r = rand(10) % N
    
    puts "r: " + r.to_s
    
    # compute s ≡ r² (mod N) - s is congruent to r squared modulo N
    s = (r * r) % N
    
    puts "s: " + s.to_s

    # verifier:
    
    # random value β ∈ {0, 1} (Beta is an random element of the set {0, 1})
    β = rand(2)
    
    puts "β: " + β.to_s
    
    # prover:
    
    if β == 0
        z = r % N
    elsif β == 1
        z = (x * r) % N
    end
    
    puts "z: " + z.to_i.to_s
    
    # verifier:

    # compute z² modulo N
    z² = (z * z) % N
    
    if β == 0
        # z² ≡ s (mod N) - z squared is congruent to s modulo N
        if z² == s % N
            puts ">: proof accepted (β = 0)"
            proof_accepted_counter += 1
        elsif
            puts ">: proof rejected (β = 0)"
        end
    elsif β == 1
        # z² ≡ ys (mod N) - z squared is congruent to y times s, modulo N
        if z² == (y * s) % N
            puts ">: proof accepted (β = 1)"
            proof_accepted_counter += 1
        elsif
            puts ">: proof rejected (β = 1)"
        end
    end
    
    # if y is a square modulo N, then z ≡ xᵝr (mod N)
    # so z² ≡ x²ᵝr² ≡ yᵝs (mod N)
    
    puts
    puts "z² ≡ x²ᵝr² ≡ yᵝs (mod N)"
    padding = "  " # * (z² % N).to_i.to_s.length
    puts "        z² ≡ " + (z² % N).to_i.to_s + padding + " (mod N)"
    puts "     x²ᵝr² ≡ " + ((x ** (2 * β)) * (r * r) % N).to_i.to_s + padding + " (mod N)"
    puts "       yᵝs ≡ " + (((y ** β) * s) % N).to_i.to_s + padding + " (mod N)"
    puts
end

puts "proof rejected " + (n - proof_accepted_counter).to_s + " times"
puts "proof accepted " + proof_accepted_counter.to_s + " times"
