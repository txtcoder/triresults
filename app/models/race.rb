class Race
  include Mongoid::Document
  include Mongoid::Timestamps

  field :n, type: String, as: :name
  field :date, type: Date
  field :loc, type: Address, as: :location

  scope :upcoming, -> {where(:date.gte=>Date.current)}
  scope :past, -> {where(:date.lt=>Date.current)}
  embeds_many :events, as: :parent, class_name: "Event", order: [:order.asc]
  has_many :entrants, foreign_key: "race._id", dependent: :delete, order:[:secs.asc, :bib.asc]
end
