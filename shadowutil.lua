local function setup(xdis, ydis, shadowcolor)
    local function shadow(instance)
        local class = instance.ClassName
        local shadow = instance:Clone()
        shadow.Parent = instance
        shadow.Position = UDim2.new(0,  xdis, 0, ydis)
        shadow.ZIndex = instance.ZIndex
        shadow.AnchorPoint = Vector2.new(0,0)
        shadow.Name = "GeneratedShadow"
        instance.ZIndex = instance.ZIndex + 1
        local colorprop
        if class:find("Text") then 
            colorprop = "TextColor3"
        elseif class:find("Image") then
            colorprop = "ImageColor3"   
        else
            colorprop = "BackgroundColor3"
        end
        if colorprop then 
            shadow[colorprop] = shadowcolor
        else
            error("Invalid GuiInstance")
        end
    end
    
    return {shadow = shadow}
end

return {setup = setup}