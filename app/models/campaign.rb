class Campaign < ApplicationRecord
 	belongs_to :user
  	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 30 }
	validates :smtp_server, presence: true, length: { maximum: 30 }
	validates :from, presence: true, length: { maximum: 30 }
	validates :from_alias, presence: true, length: { maximum: 30 }
	validates :subject, presence: true, length: { maximum: 80 }
	validates :template_id, presence: true
	validates :victims, presence: true, length: { maximum: 1000 }
end
