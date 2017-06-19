class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true
  has_many :notes
  has_many :likes
  has_many :like_notes, through: :likes, source: :note

  def set_image(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_images/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.image = file_name
    end
  end
end
