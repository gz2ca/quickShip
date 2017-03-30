require 'easypost'
EasyPost.api_key = Rails.application.secrets.EASYPOST_KEY

class PackagesController < ApplicationController
	
	def index
		redirect_to :root
	end

	def new
		@package = Package.new
	end

	def create
		@package = Package.new(package_params)

		@to_address = EasyPost::Address.create(
		  :verify => ["delivery"],
		  :name => @package.to_name,
		  :street1 => @package.to_address,
		  :city => @package.to_city,
		  :state => @package.to_state,
		  :zip => @package.to_zip,
		  :country => @package.to_country,
		  :phone => @package.to_phone
		)

		@from_address = EasyPost::Address.create(
		  :name => @package.from_name,
		  :street1 => @package.from_address,
		  :city => @package.from_city,
		  :state => @package.from_state,
		  :zip => @package.from_zip,
		  :country => @package.from_country,
		  :phone => @package.from_phone
		)

		@parcel = EasyPost::Parcel.create(
		  :width => @package.width,
		  :length => @package.length,
		  :height => @package.height,
		  :weight => @package.weight
		)

		# shipment = EasyPost::Shipment.create(
		#   :to_address => to_address,
		#   :from_address => from_address,
		#   :parcel => parcel,
		# )

		# @rates = shipment['rates']

		# shipment.buy(
		#   :rate => shipment.lowest_rate
		# )

		@verify =  @to_address.verifications
		# if @verify.delivery.success == false 
		# 	render 'new'
		# end

		# shipment.insure(amount: 100)

		# @insurance = shipment.insurance

		# @label = shipment.postage_label.label_url

		if @package.save and @verify.delivery.success
			redirect_to @package
		else
			render 'new'
		end
	end

	def show
		@package = Package.find(params[:id])

		to_address = EasyPost::Address.create(
		  :name => @package.to_name,
		  :street1 => @package.to_address,
		  :city => @package.to_city,
		  :state => @package.to_state,
		  :zip => @package.to_zip,
		  :country => @package.to_country,
		  :phone => @package.to_phone
		)

		from_address = EasyPost::Address.create(
		  :name => @package.from_name,
		  :street1 => @package.from_address,
		  :city => @package.from_city,
		  :state => @package.from_state,
		  :zip => @package.from_zip,
		  :country => @package.from_country,
		  :phone => @package.from_phone
		)

		parcel = EasyPost::Parcel.create(
		  :width => @package.width,
		  :length => @package.length,
		  :height => @package.height,
		  :weight => @package.weight
		)

		shipment = EasyPost::Shipment.create(
		  :to_address => to_address,
		  :from_address => from_address,
		  :parcel => parcel
		)

		@rates = shipment['rates']

		shipment.buy(
		  :rate => shipment.lowest_rate
		)

		# # @verify =  to_address.verifications
		# # if @verify.delivery.success == false 
			
		# # 	@verify.delivery.errors.each do |msg|
		# # 		flash[:error] = msg.message
		# # 	end
		# # end

		# # # shipment.insure(amount: 100)

		# # # @insurance = shipment.insurance

		@label = shipment.postage_label.label_url
		
		# @label = shipment.postage_label
	end

	def label 
		@package = Package.find(params[:id])

	end
	
	private 
		def package_params
			params.require(:package).permit(:from_name, :to_name, :from_address, :from_city, :from_state, :from_zip, :from_country, :from_phone, :to_name, :to_address, :to_city, :to_state, :to_zip, :to_country, :to_phone, :length, :width, :height, :weight)
		end
end
