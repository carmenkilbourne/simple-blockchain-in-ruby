class Block
  attr_reader :index, :timestamp, :transactions, 
							:transactions_count, :previous_hash, 
							:nonce, :hash, :type,:difficulty

              
  def initialize(index, transactions, previous_hash, difficulty)
    @index         		 	 = index
    @timestamp      	 	 = Time.now
    @transactions 	 		 = transactions
		@transactions_count  = transactions.size
    @previous_hash 		 	 = previous_hash
    @nonce, @hash  		 	 = compute_hash_with_proof_of_work(difficulty)
    @difficulty          = difficulty
    @type                ="Money transactions"
  end

	def compute_hash_with_proof_of_work(difficulty)
		nonce = 0
		loop do 
			hash = calc_hash_with_nonce(nonce)
			if hash.start_with?(difficulty)
				return [nonce, hash]
			else
				nonce +=1
			end
		end
	end
	
  def calc_hash_with_nonce(nonce=0)
    sha = Digest::SHA256.new
    sha.update( nonce.to_s + 
								@index.to_s + 
								@timestamp.to_s + 
								@transactions.to_s + 
								@transactions_count.to_s +	
								@previous_hash )
    sha.hexdigest 
  end

  def self.first( *transactions )    # Create genesis block
    random_hash = Digest::SHA256.hexdigest(rand.to_s)
    difficulty = random_hash[0, 2]
    Block.new(0, transactions, random_hash, difficulty)
  end
def get_difficulty
end

  def self.next( previous, transactions )
    Block.new( previous.index+1, transactions, previous.hash,previous.difficulty )
  end
end  # class Block