module ModularExponentiator
    def exponentiate_modularly(base, index, modulus)
        if base == 0 return 0
        if index == 0 return 1

        if base > modulus base %= modulus
        if index == 1 return base

        int residue = 1
        
        while index > 0
            if index & 1 == 1
                residue = (residue * base) % modulus
            end
            
            base = (base * base) % modulus
            index >>= 1
        end
        
        return residue;   
    end
end

module QuadraticResiduosityDeciders
    
    # Prime Modulus Quadratic Residuosity Decider Algorithm
    
    def decide_prime_modulus_quadratic_residuosity(p, x)
        i = (p - 1) >> 1
        b = exponentiate_modularly(x, i, p)
        
        if b == 1
            return true 
        else 
            return false
        end
    end
    
    # Known Factorization Composite Modulus Quadratic Residuosity Decider Algorithm
    
    def decide_known_factorization_composite_modulus_quadratic_residuosity(p, q, x)
        if decide_prime_modulus_quadratic_residuosity(p, x) and decide_prime_modulus_quadratic_residuosity(q, x)
            return true
        else
            return false
        end
    end
end

# Perfect Zero-Knowledge Proof

include QuadraticResiduosityDeciders
include ModularExponentiator

# get two primes
print "Enter first prime number: "
p = gets.chomp.to_i
print "Enter second prime number: "
q = gets.chomp.to_i

# product of the two primes
N = p * q

puts

puts "N æ " + N.to_i.to_s + " æ " + p.to_s + " ⋅ " + q.to_s

puts
    
# get square modulo N (quadratic residue)
print "Enter a quadratic residue modulo " + N.to_s + ": "
y = gets.chomp.to_i

puts

loop do
    # check residuosity
    if decide_known_factorization_composite_modulus_quadratic_residuosity(p, q, y)
        puts y.to_s + " is a quadratic residue modulo " + N.to_s + "."
        break
    else
        puts y.to_s + " is a quadratic nonresidue modulo " + N.to_s + "."
        
        puts
        
        # get square modulo N (quadratic residue)
        print "Enter a quadratic residue modulo " + N.to_s + ": "
        y = gets.chomp.to_i
        
        puts
    end
end

puts

# square root of square modulo N
print "Enter a square root of " + y.to_s + " mod " + N.to_s + ": "
x = gets.chomp.to_i

# the prover seeks to show that y is a square modulo N
# x² ≡ y (mod N)

puts

# number of challenge-response rounds
print "Enter number of challenge-response rounds (n): "
n = gets.chomp.to_i

puts

# number of proofs accepted
proof_accepted_counter = 0

n.times do |iteration|
    puts "n: " + (iteration + 1).to_s
    
    # prover:
    
    # random number
    r = rand(10000) % N
    
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
            puts "➤➤ proof accepted (β æ 0)"
            proof_accepted_counter += 1
        elsif
            puts "➤➤ proof rejected (β æ 0)"
        end
    elsif β == 1
        # z² ≡ ys (mod N) - z squared is congruent to y times s, modulo N
        if z² == (y * s) % N
            puts "➤➤ proof accepted (β æ 1)"
            proof_accepted_counter += 1
        elsif
            puts "➤➤ proof rejected (β æ 1)"
        end
    end
    
    # if y is a square modulo N, then z ≡ xᵝr (mod N)
    # so z² ≡ x²ᵝr² ≡ yᵝs (mod N)
    
    puts
    puts "z² ≡ x²ᵝr² ≡ yᵝs (mod N)"
    length = (z² % N).to_i.to_s.length
    if length > 3
        padding = ""
    else
        padding = " " * (3 - (z² % N).to_i.to_s.length)
    end
    puts "        z² ≡ " + (z² % N).to_i.to_s + padding + " (mod N)"
    puts "     x²ᵝr² ≡ " + ((x ** (2 * β)) * (r * r) % N).to_i.to_s + padding + " (mod N)"
    puts "       yᵝs ≡ " + (((y ** β) * s) % N).to_i.to_s + padding + " (mod N)"
    puts
end

puts "proof rejected " + (n - proof_accepted_counter).to_s + " times"
print "proof accepted " + proof_accepted_counter.to_s + " times"
puts " (every time)" if proof_accepted_counter == n

end