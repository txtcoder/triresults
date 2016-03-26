class Event
  include Mongoid::Document
  field :o, type: Integer, as: :order
  field :n, type: String, as: :name
  field :d, type: Float, as: :distance
  field :u, type: String, as: :units
  embedded_in :parent, polymorphic:true, touch: true

  def meters
    result=0
    if units=="meters"
        result =distance
    elsif units=="kilometers"
        result =distance*1000
    elsif units=="miles"
        result = distance/0.000621371
    elsif units=="yards"
        results = distance*0.9144
    else
        nil
    end
  end

  def miles
    if meters
        meters/1609.344
    else
        nil
    end
  end

end
