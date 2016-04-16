class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
# we have taken out :registerable, because we don't want anyone registering as a admin, even though they might do a better job than you!
# but first we need to create the first admin user to do this, add this to the seed.rb file and run "rake db:seed" "Admin.create email: 'bizygrove@hotmail.co.uk', password: 'Star2015'"