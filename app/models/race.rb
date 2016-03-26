class Race
  include Mongoid::Document
  include Mongoid::Timestamps

  field :n, type: String, as: :name
  field :date, type: Date
  field :loc, type: Address, as: :location

  embeds_many :events, as: :parent, class_name: "Event", order: [:order.asc]
end
