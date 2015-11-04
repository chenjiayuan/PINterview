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
#

class User < ActiveRecord::Base
  has_secure_password
end
