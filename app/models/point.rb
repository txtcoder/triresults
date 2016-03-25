class Point
    attr_accessor :longitude, :latitude

    def mongoize
        if @longitude && @latitude
            return {:type =>"Point", :coordinates=>[@longitude,@latitude]}
        else
            nil
        end
    end

    def self.mongoize(object)
        case object
            when nil then nil
            when Hash then Point.demongoize(object).mongoize
            when Point then object.mongoize
            else nil
        end
    end

    def self.demongoize(object)
        case object
            when nil then nil
            when Hash 
                point = Point.new
                point.longitude=object[:coordinates][0] if object[:coordinates]
                point.latitude=object[:coordinates][1] if object[:coordinates]
                point
            else nil
        end
    end
    
    def self.evolve(object)
        self.mongoize(object)
    end
end
