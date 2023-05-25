class Admin < ApplicationRecord
  ROLE = 'admin'.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.admins_except_creator(creator)
    where.not(id: creator.id)
  end
end
