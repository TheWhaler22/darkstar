-----------------------------------------
-- ID: 4142
-- Item: Pro-Ether +2
-- Item Effect: Restores 310 MP
-----------------------------------------

require("scripts/globals/status");
require("scripts/globals/settings");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
result = 0;
mMP = target:getMaxMP();
cMP = target:getMP();

if (mMP == cMP) then
	result = 56; -- Does not let player use item if their hp is full

elseif (target:hasStatusEffect(EFFECT_MEDICINE)) then
    result = 111;
end
	
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	mMP = target:getMaxMP();
	cMP = target:getMP();
		
	dif = mMP - cMP;
	if(dif > 310) then
		heal = 310;
	else
		heal = dif;
	end
	
	target:addMP(heal*ITEM_POWER);
	target:messageBasic(25,0,heal);
	target:addStatusEffect(EFFECT_MEDICINE,0,0,900);
	
end;