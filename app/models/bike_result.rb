class BikeResult < LegResult
    field :mph, type: Float
    def calc_ave
        if secs && event
            self[:mph]=event.miles*3600/secs
        end
    end
end
