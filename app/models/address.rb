class Address
    attr_accessor :city, :state, :location
    def initialize(city,state=nil,loc=nil)
        @city=city
        @state=state
        @location=loc
    end

    def mongoize
        {:city => @city, :state => @state, :loc => @location.mongoize}
    end

    def self.mongoize(object)
        if object.is_a?(Address)
            object.mongoize
        elsif object.is_a?(Hash)
            Address.demongoize(object).mongoize
        else
            nil
        end
    end

    def self.demongoize(object)
        case object
        when nil then nil
        when Hash then
            address=Address.new(object[:city],object[:state],Point.demongoize(object[:loc]))
            address
        else nil
        end
    end

    def self.evolve(object)
        self.mongoize(object)
    end
end
