# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string
#  email           :string
#  password_digest :string
#  grad_class      :string
#  major           :string
#

class User < ActiveRecord::Base
  has_secure_password
  before_save :downcase_email
  validates :username, presence: true, length: { maximum: 50 }
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
end
