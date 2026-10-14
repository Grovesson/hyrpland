-- Create "rows" layout and sign it to ws6-10
hl.layout.register("rows", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then
            return
        end

        for i, target in ipairs(ctx.targets) do
            target:place(ctx:row(i, n))
        end
    end,
})
