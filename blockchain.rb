###########################
#	Improved version of "Build your own blockchain from scratch in 20 lines of Ruby!"	
#		from https://github.com/openblockchains/awesome-blockchains/tree/master/blockchain.rb
#  
#   and inspired by
#     Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python by Gerald Nash
#     see https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
#
#	Now, Blockchain with prompt transactions, transactions counter for each block, 
#											 ledger, proof of work and dynamic variable name. 
#
#	This Blockchain can be set as a loop for infinite using of the Blockchain.
#
#
#  to run use:
#    $ ruby ./blockchain.rb
#
#
#

require 'digest'    							# For hash checksum digest function SHA256
require 'pp'        							# For pp => pretty printer
# require 'pry'                     # For on the fly debugging
require_relative 'block'					# class Block
require_relative 'transaction'		# method Transactions

LEDGER = []						#registro

#####
## Blockchain building, one block at a time.
##  This will create a first block with fake transactions
## 	and then prompt user for transactions informations and set it in a new block.
## 	
## Each block can take multiple transaction
## 	when a user has finish to add transaction, 
##  the block is added to the blockchain and writen in the ledger


def create_first_block
	i = 0
	instance_variable_set( "@b#{i}", 
												 Block.first( 
													{ from: "Bankia", to: "Carmen", what: "Dollars", qty: 1000, why:"Retirada de dinero"},
													{ from: "BBVA", to: "Maria", what: "Bitcoin", qty: 3 ,why:"Pago por intereses depositados"},
													{ from: "Fondo Europeo", to: "Paco", what: "Euros", qty: 300000, why:"Pago por indemnizacion"})
											 )
	LEDGER << instance_variable_get("@b#{i}")
    p "============================"
    pp instance_variable_get("@b#{i}")
	pp @b0
	p "============================"
	add_block
end
	
	
	
def add_block
	i = 1
	loop do
		instance_variable_set("@b#{i}", Block.next( (instance_variable_get("@b#{i-1}")), get_transactions_data))
		LEDGER << instance_variable_get("@b#{i}")
		p "============================"
		pp instance_variable_get("@b#{i}")
		p "============================"
		i += 1
	end
end

def launcher
	puts "==========================="
	puts ""
	puts "Welcome to Blockchain !"
	puts ""
	puts "Wait for the genesis (the first block of the blockchain)"
	puts ""
	for i in 1..10
		print "."
		sleep 0.1
		break if i == 10
	end
	puts "" 
	puts "" 
	puts "==========================="
	create_first_block
end

launcher
