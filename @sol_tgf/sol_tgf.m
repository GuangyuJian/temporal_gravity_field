classdef sol_tgf<handle

    properties

        sol_filter  @sol_filter
        study_basin  @study_basin

        pnm
        smf
        cmf
    end
    %%
    methods
        function self=sol_tgf(sol_filter,study_basin)

            self.sol_filter=sol_filter;
            self.study_basin=study_basin;
            self.get_sob();
        end
         [self]=get_sob(self);
    end
end


