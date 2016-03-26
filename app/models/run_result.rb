class RunResult < LegResult
    field :mmile, type: Float, as: :minute_mile
    def calc_ave
        minute_mile=1.0
    end
end
