class User < ApplicationRecord

  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  validates :password, on: :create, length: {in: 6...128}
  validates :password, length: {in: 6...128}, on: :update, allow_blank: true

end

class Error < StandardError

end

private 
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end

