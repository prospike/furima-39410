class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :day_of_birth, presence: true


  validate :password_complexity
  validate :name_format
  validate :name_kana_format

  private

  def password_complexity
    return if password.blank?

    return if password.match?(/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i)

    errors.add(:password, 'は、半角英数字混合で入力してください')
  end

  def name_format
    errors.add(:family_name, 'は全角（漢字・ひらがな・カタカナ）で入力してください') unless family_name.match?(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/)
    return if first_name.match?(/\A[ぁ-んァ-ヶ一-龥々ー]+\z/)

    errors.add(:first_name, 'は全角（漢字・ひらがな・カタカナ）で入力してください')
  end

  def name_kana_format
    errors.add(:family_name_kana, 'は全角カタカナで入力してください') unless family_name_kana.match?(/\A[ァ-ヶー－]+\z/)
    return if first_name_kana.match?(/\A[ァ-ヶー－]+\z/)

    errors.add(:first_name_kana, 'は全角カタカナで入力してください')
  end

end
