local _cache = {}

--[[
    LoadAnimation easily loads and caches your animations for easy reuse.
    ```lua
    LoadAnimation(Character, AnimationId):Play()
    ```
    @param target Model | Player | Humanoid | AnimationController
    @param animationId string | number
    @return AnimationTrack
--]]
return function(target: Model | Player | Humanoid | AnimationController, animationId: string | number): AnimationTrack
    local id: string = (typeof(animationId) == "string") and animationId or "rbxassetid://".. tostring(animationId):match("%d+")
    local key: string =  "track_".. id

    if _cache[key] then
        return _cache[key]
    else
        local function getAnimator(src: Instance): Animator?
            local base = src:FindFirstChildOfClass("Humanoid") or src:FindFirstChildOfClass("AnimationController")
            return base:FindFirstChildOfClass("Animator")
        end

        local animator: Animator?
        if target:IsA("Model") then
            animator = getAnimator(target)
        elseif target:IsA("Player") then
            target = target.Character
            animator = getAnimator(target)
        else
            animator = target:FindFirstChildOfClass("Animator")
        end

        assert(animator, "Animator object not found.")

        local animation: Animation = Instance.new("Animation")
        animation.AnimationId = id

        local track: AnimationTrack = animator:LoadAnimation(animation)
        animation:Destroy()

        _cache[key] = track
        return track
    end
end