class SwimResult < LegResult
    field  :pace_100, type: Float
    def calc_ave
        pace_100=1.0
    end
end
