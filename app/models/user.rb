class User < ApplicationRecord
  devise :authy_authenticatable, :authy_lockable, :database_authenticatable, :lockable,
   :registerable, :recoverable, :rememberable, :validatable
end
