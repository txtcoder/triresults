class RacerInfo
  include Mongoid::Document
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }
  field :first_name, type: String, as: :fn
  field :last_name, type: String, as: :ln
  field :gender, type: String, as: :g
  field :birth_year, type: Integer, as: :yr
  field :residence, type: Address, as: :res
end
