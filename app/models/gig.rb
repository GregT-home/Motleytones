# frozen_string_literal: true

class Gig < ApplicationRecord
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true
  validates :name, uniqueness: {
    scope: :date,
    message: "record with same date and name already exists"
  }

  scope :published,  -> { where(published: true) }
  scope :ascending,  -> { order(date: :asc) }
  scope :descending, -> { order(date: :desc) }
  scope :unique,     -> { order(name: :asc).uniq(&:name) }
  scope :expired,    -> { where("date + days < ?", Time.zone.today) }
  scope :active,     -> { where("date + days >= ?", Time.zone.today) }
end
