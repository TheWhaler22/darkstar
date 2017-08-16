---------------------------------------------------
-- Magic Mortar
---------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    local effects = master:countEffect(EFFECT_LIGHT_MANEUVER)
    if effects > 0 then
        return effects
    else
        return -1
    end
end

function onAutomatonAbility(automaton, target, skill, tp, master, action)
    local ftp

    if not USE_ADOULIN_WEAPON_SKILL_CHANGES then
        ftp = 0.5 + ((0.5/3000) * tp)
        skill:setSkillchain(119)
    else
        -- Might be wrong, it may only use max hp in its new form, also it may be able to miss and take defense into account as well
        if tp >= 3000 then
            ftp = 2.5
        elseif tp >= 2000 then
            ftp = 1.75 + ((0.75/3000) * tp)
        else
            ftp = 1.5 + ((0.25/3000) * tp)
        end
        skill:setSkillchain(119) -- No WS exists that is Liquefaction + Fusion
    end

    local hpdamage = (automaton:getMaxHP() - automaton:getHP()) * ftp
    local skilldamage = automaton:getSkillLevel(22) * ftp
    local damage = (hpdamage > skilldamage) and hpdamage or skilldamage

    if damage > 0 then
       target:addTP(20)
       automaton:addTP(80)
    end

    target:delHP(damage)
    return damage
end
