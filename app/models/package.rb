class Package < ActiveRecord::Base
	validates :from_name, presence: true

	validates_format_of :from_zip,
                    :with => %r{\d{5}(-\d{4})?},
                    :message => "%{value} is not a valid zipcode. Should be in the format of 12345 or 12345-1234"
                    
    validates_format_of :to_zip,
                    :with => %r{\d{5}(-\d{4})?},
                    :message => "%{value} is not a valid zipcode. Should be in the format of 12345 or 12345-1234"                
end
