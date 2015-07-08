class Admin < ActiveRecord::Base
	validates_presence_of :name
	validates :admin_id,
						presence: true,
						uniqueness: true
	validates_presence_of :authorized
end
