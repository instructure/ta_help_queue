class Student < ActiveRecord::Base
	validates_presence_of :name
	validates :id_num,
						presence: true,
						uniqueness: true
	has_one :request
end
