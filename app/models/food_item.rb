class FoodItem < ApplicationRecord

	has_many :sides
	has_one :restaurant
	validates :food_name, presence:true
	validates :price, presence:true, :numericality => true
	validates :category, presence:true
	validates :allergy_info, presence:true
	validates :dietary_info, presence:true, :numericality => true
	validate :dietary_info_format

	# checks that restaurant exists
	validate :check_restaurant

	#checks uniqueness of food item at its restaurant
	validate :unique_at_restaurant


	# checks valid input for dietary_info
	# 0 --> no info
	# 1 --> vegetarian
	# 2 --> vegan
	def dietary_info_format
		if dietary_info < 0 or dietary_info > 2
			errors.add(:dietary_info, "invalid dietary info code submitted incorrectly")
		end
	end

	def format_price()
	    string_tip = price.to_s
	    if string_tip.index('.') == -1
	      string_tip += '.00'
	    elsif string_tip.index('.') == string_tip.size - 2
	      string_tip += '0'
	    end
	    return string_tip
  	end

  	def check_restaurant
  		if Restaurant.find_by_id(restaurant_id).nil?
  		 	errors.add(:restaurant_id, 'restaurant does not exist')
  		end
  	end

	def unique_at_restaurant
		FoodItem.where(:food_name => food_name).all.each do |f|
			if f.id != id and f.restaurant_id == restaurant_id and f.size == size
				errors.add(:restaurant_id, 'not a unique entry for this restaurant')
			end
		end
		
	end




end
