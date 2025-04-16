function Item:addTestAugment()
	-- MOD_TYPE (STANCE), TYPE, AMOUNT, MOD_FACTOR, CHANCE, COMBAT_TYPE, ORIGIN_TYPE, ...
	local modifier = DamageModifier(ATTACK_MOD, ATTACK_MODIFIER_CONVERSION, 300, PERCENT_MODIFIER, 100, COMBAT_NONE, ORIGIN_NONE)
	self:addAugment(Augment("Test", "Increase the damage by 300%.", {modifier}))
end