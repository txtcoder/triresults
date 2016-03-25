class Point
    attr_accessor :longitude, :latitude

    def initialize(long,lat)
        @longitude=long
        @latitude=lat
    end

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
                point = Point.new(object[:coordinates][0], object[:coordinates][1])
            else nil
        end
    end
    
    def self.evolve(object)
        self.mongoize(object)
    end
end
