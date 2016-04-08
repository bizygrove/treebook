class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :statuses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
  							uniqueness: true,
  							format: {
  								with: /\A[a-zA-Z\-\_]+\Z/,
  								message: 'Must be formatted correctly.'
  							}

  def full_name
  	first_name + " " + last_name
  end

  def gravatar_url
      stripped_email = email.strip # remove any spaces before or after
      downcased_email = stripped_email.downcase # makes all charters lowercase
      hash = Digest::MD5.hexdigest(downcased_email) # makes downcased_email into MD5 hash

      "http://gravatar.com/avatar/#{hash}"

  end



end
