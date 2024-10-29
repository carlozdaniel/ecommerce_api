class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
