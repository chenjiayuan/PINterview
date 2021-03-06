# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string
#  email               :string
#  password_digest     :string
#  major               :string
#  grad_class          :string
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class User < ActiveRecord::Base
  has_many :pins
  has_many :favorite_pins
  has_many :favorites, through: :favorite_pins, source: :pin

  has_secure_password
  before_save :downcase_email
  after_save :create_identicon

   # Avatar file handler
  has_attached_file :avatar, styles: { medium: "30x30>", thumb: "30x30>" }, default_url: ":id_identicon.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :username, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@berkeley+\.edu+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :grad_class, presence: true, length: { maximum: 50 }
  validates :major, presence: true, length: { maximum: 50 }
  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  def create_identicon 
    RubyIdenticon.create_and_save("#{self.username}", "app/assets/images/#{self.id}_identicon.png")
  end

end
