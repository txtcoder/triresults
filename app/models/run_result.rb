class RunResult < LegResult
    field :mmile, type: Float, as: :minute_mile
    def calc_ave
        if secs && event
            self[:minute_mile]=(secs/60)/event.miles
        end
    end
end
