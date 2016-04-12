class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :statuses
  has_many :documents

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
  							uniqueness: true,
  							format: {
  								with: /\A[a-zA-Z\-\_]+\Z/,
  								message: 'Must be formatted correctly.'
  							}
    validates :status_colour, presence: true,
                format: {
                  with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i,
                  message: 'Status Colour must be in hex format.'
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

  def status_color opacity
    input = status_colour
    if (input.mb_chars.length == 7)
      a = ( input.match /#(..?)(..?)(..?)/ )[1..3]
      a.map!{ |x| x + x } if input.size == 4
      "rgba(#{a[0].hex},#{a[1].hex},#{a[2].hex}," + opacity + ")"
    end
  end

end
