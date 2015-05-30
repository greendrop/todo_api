class Todo < ActiveRecord::Base
  extend Enumerize

  enumerize :state, in: {none: 0, done: 1}, default: :none, predicates: {prefix: true}, scope: true

  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true, length: {maximum: 255}
  validates :state, presence: true

end
