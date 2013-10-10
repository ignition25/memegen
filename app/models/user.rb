class User < ActiveRecord::Base
	has_many :votes
	has_and_belongs_to_many :groups
	
	validates_presence_of :username
	validates_uniqueness_of :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
