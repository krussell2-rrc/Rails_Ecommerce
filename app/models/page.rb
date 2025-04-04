class Page < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "content", "created_at", "id", "id_value", "name", "updated_at" ]
  end
end
