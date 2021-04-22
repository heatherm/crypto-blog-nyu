class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :authy_authenticatable, :authy_lockable, :database_authenticatable, :lockable,
   :registerable, :recoverable, :rememberable, :validatable
  # devise :authy_authenticatable, :authy_lockable, :database_authenticatable, :lockable         
end
