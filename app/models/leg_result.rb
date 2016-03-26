class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant

  embeds_one :event, as: :parent, class_name: "Event"

  validates :event, presence: true

  def calc_ave
  end

  after_initialize do |doc|
    doc.calc_ave
  end

  def sec= value
    self[:secs]=value
    calc_ave
  end
end
