class Client < ApplicationRecord
  ROLE = 'client'.freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  belongs_to :current_order, class_name: "Order", optional: true
  has_many :sales
end
