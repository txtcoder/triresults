class Placing
    attr_accessor :name, :place

    def initialize(name,place)
        @name = name
        @place = place
    end

    def mongoize
        {:name=>@name, :place => @place}
    end

    def self.mongoize(object)
        if object.is_a?(Placing)
            object.mongoize
        elsif object.is_a?(Hash)
            self.demongoize(object).mongoize
        else
            nil
        end
    end

    def self.demongoize(object)
        if object.is_a?(Hash)
            placing = Placing.new(object[:name],object[:place])
            placing
        else
            nil
        end
    end

    def self.evolve(object)
        self.mongoize(object)
    end

end
