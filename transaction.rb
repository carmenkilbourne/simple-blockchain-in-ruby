def get_transactions_data

	transactions_block ||= []
	blank_transaction = Hash[from: "", to: "",
													 what: "", qty: "",why:""]
	loop do
		puts "" 
		puts "Enter your name for the new transaction"
		from = gets.chomp
		puts "" 
		what = validate_currency
		puts "" 
		qty=validate_quantity
		puts "" 
		puts "Who do you want to send it to ?"
		to 	 = gets.chomp
		puts "" 
		puts "Why are you making this transaction ?"
		why = gets.chomp

		transaction = Hash[from: "#{from}", to: "#{to}", 
											 what: "#{what}", qty: "#{qty}",why: "#{why}"]
		transactions_block << transaction

		puts "" 
		puts "Do you want to make another transaction for this block ? (Y/n)"
		new_transaction = gets.chomp.downcase

		if new_transaction == "y"
			self
		else
			return transactions_block
			break
		end
	end
end
def validate_quantity
	while true do
		puts "How much quantity ?"
		qty  = gets.chomp.to_f
		break if  qty>0
	end
	return qty

end
def validate_currency

	while true do
		puts "What do you want to send(Euros/Dollars/Bitcoin)?"
		what = gets.chomp
		what_downcase =what.downcase 
		break if (what_downcase == "euros" || what_downcase == "dollars" || what_downcase == "bitcoin")
		end
	return what_downcase
end

