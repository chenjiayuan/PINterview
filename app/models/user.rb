# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  email           :string
#  grad_class      :string
#  major           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  def user_params
      params.require(:user).permit(:username, :password, :email, :grad_class, :major)
  end

  # before_save { self.email = email.downcase }
  # validates :username,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@berkeley+\.edu+\z/i
  # validates :email, presence: true, length: { maximum: 255 },
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }
  # validates :grad_class, presence: true, length: { maximum: 100 }
  # validates :major, presence: true, length: { maximum: 100 }
end
