class Race
  include Mongoid::Document
  include Mongoid::Timestamps

  field :n, type: String, as: :name
  field :date, type: Date
  field :loc, type: Address, as: :location
  field :next_bib, type: Integer, default: ->{0}

  DEFAULT_EVENTS = {"swim"=>{:order=>0, :name=>"swim", :distance=>1.0, :units=>"miles"},
            "t1"=> {:order=>1, :name=>"t1"},
            "bike"=>{:order=>2, :name=>"bike", :distance=>25.0, :units=>"miles"},
            "t2"=> {:order=>3, :name=>"t2"},
            "run"=> {:order=>4, :name=>"run", :distance=>10.0, :units=>"kilometers"}}

  scope :upcoming, -> {where(:date.gte=>Date.current)}
  scope :past, -> {where(:date.lt=>Date.current)}
  embeds_many :events, as: :parent, class_name: "Event", order: [:order.asc]
  has_many :entrants, foreign_key: "race._id", dependent: :delete, order:[:secs.asc, :bib.asc]

    DEFAULT_EVENTS.keys.each do |name|
        define_method("#{name}") do
            event=events.select {|event| name==event.name}.first
            event||=events.build(DEFAULT_EVENTS["#{name}"])
        end

        ["order","distance","units"].each do |prop|
            if DEFAULT_EVENTS["#{name}"][prop.to_sym]
                define_method("#{name}_#{prop}") do
                    event=self.send("#{name}").send("#{prop}")
                end
                define_method("#{name}_#{prop}=") do |value|
                     event=self.send("#{name}").send("#{prop}=", value)
                end
            end
        end
    end

    def self.default
        Race.new do |race|
            DEFAULT_EVENTS.keys.each{|leg|race.send("#{leg}")}
        end
    end
    
    def next_bib
        self[:next_bib]+=1
    end

    ["city", "state"].each do |action|
        define_method("#{action}") do
            self.location ? self.location.send("#{action}") : nil
        end
        define_method("#{action}=") do |name|
            object=self.location ||= Address.new
            object.send("#{action}=", name)
            self.location=object
        end
    end
end
