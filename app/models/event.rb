class Event < ApplicationRecord
  belongs_to :user, optional: true #認証機能できたらop削除
end
