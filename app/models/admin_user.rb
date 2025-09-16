class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

    # ✅ Allow only safe attributes to be searchable/sortable
  def self.ransackable_attributes(_auth_object = nil)
    %w[id email created_at updated_at]
  end

  # ✅ If you don’t need to search through associations, return empty array
  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
