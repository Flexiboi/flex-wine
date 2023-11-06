# flex-wine
QB Based Wine making script
</br>
<b>Ever wanted to make wine?</b>
</br>
<b>Then this is the perfect script for you!</b>
</br>
# How does it work?
</br>
<b>PREVIEW: </b>https://streamable.com/hbar8f
</br>
You will have to buy all the ungredients and stuff to start working on your wine.
</br>
First you will have to gather some berries.
</br>
Then squeez them in your bucket..
</br>
Lastly put your barrel down and start brewing wine with the berries you squeezed.
</br>
Once ready, you can fill up your winebottle.
</br>
</br>
Once you have filled your barrel, you will have to wait till it ages before you can take out wine.
</br>
The longer you wait the older the barrel gets.
</br>
If it gets to old it turns bad and the barrel gets deleted.
</br>

# Install
</br>
You will need <b>qb-menu</b> and some sql script.
</br>
</br>
<b>items.lua</b>
</br>

```
-- Flex-Wine
['berry'] 					 	 = {['name'] = 'berry', 						['label'] = 'Besjes', 					['weight'] = 300, 		['type'] = 'item', 		['image'] = 'besjes.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['wine_barrel'] 				 = {['name'] = 'wine_barrel', 					['label'] = 'Wijnvat', 					['weight'] = 300, 		['type'] = 'item', 		['image'] = 'wijnvat.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['wine_emptybucket'] 			 = {['name'] = 'wine_emptybucket', 				['label'] = 'Lege Emmer', 				['weight'] = 300, 		['type'] = 'item', 		['image'] = 'emmer.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['wine_fullbucket'] 			 = {['name'] = 'wine_fullbucket', 				['label'] = 'Emmer', 					['weight'] = 300, 		['type'] = 'item', 		['image'] = 'emmer2.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['wine_yeast'] 			 		 = {['name'] = 'wine_yeast', 					['label'] = 'Gist', 					['weight'] = 300, 		['type'] = 'item', 		['image'] = 'gist.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['wine_emptybottle'] 			 = {['name'] = 'wine_emptybottle', 				['label'] = 'Lege wijnfles', 			['weight'] = 300, 		['type'] = 'item', 		['image'] = 'legefles.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['zinfandel'] 			 		 = {['name'] = 'zinfandel', 					['label'] = 'Zinfandel wijn', 			['weight'] = 300, 		['type'] = 'item', 		['image'] = 'zinfandel.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['malbec'] 			 	   		 = {['name'] = 'malbec', 						['label'] = 'Malbec wijn', 				['weight'] = 300, 		['type'] = 'item', 		['image'] = 'malbec.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['tempranillo'] 			 	 = {['name'] = 'tempranillo', 					['label'] = 'Tempranillo wijn', 		['weight'] = 300, 		['type'] = 'item', 		['image'] = 'tempranillo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['sangiovese'] 			 	   	 = {['name'] = 'sangiovese', 					['label'] = 'Sangiovese wijn', 			['weight'] = 300, 		['type'] = 'item', 		['image'] = 'wisangiovesene.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
['nebbiolo'] 			 	   	 = {['name'] = 'nebbiolo', 						['label'] = 'Nebbiolo wijn', 			['weight'] = 300, 		['type'] = 'item', 		['image'] = 'nebbiolo.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
```

</br>
<b>insert SQL</b>
</br>
</br>
<b>client > functions.lua</b>
</br>

```
function QBCore.Functions.FaceToPos(x, y, z)
    local ped = PlayerPedId()
    local positionToFace = vector3(x,y,z)
    local pedPos = GetEntityCoords(ped)
    local x = positionToFace.x - pedPos.x
    local y = positionToFace.y - pedPos.y
    local heading = GetHeadingFromVector_2d(x, y)
    SetEntityHeading(ped, heading)
end
```
