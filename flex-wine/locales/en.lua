local Translations = {
    error = {
        alreadybucket = 'You already placed a bucket..',
        cantplacehere = 'You cant place a barrel here..',
        tomanybarrels = 'You already have max placed barrels!',
        barrelgotbad = 'Your barrel has gone bad..',
        barrelfull = 'Your barrel is already full..',
        barrelnotexist = 'This barrel isnt a real barrel or bugged.. (Try to go in and out the zone)',
        barrelempty = 'This barrel is empty..',
        missingitem = 'You dont have %{value} x %{value2}',
        stoppedpluck = 'Stopped picking..',
        stoppedfilling = 'Stopped filling..',
        notowner = 'You are not the owner of this barrel..',
        stoppedsqueeze = 'You stopped squeezing berries..',
        toyoungbarrel = 'Your barrel is not old enough..',
    },
    success = {
        filledbarrel = 'You barrel is filled for %{value}%',
        filledbottle = 'Bottle is filled. There is still %{value}% in your barrel',
    },
    info = {
        plucking = 'Picking berries..',
        filling = 'Filling..',
        squeezing = 'Squeezing..'
    },
    target = {
        barrel = 'Check barrel',
        pluck = 'Pick barrels',
        squeeze = 'Squeez %{value} berries',
        pickupbucket = 'Take your bucket',

    },
    menu = {
        header = '%{value} year old barrel',
        checkfillh = 'How full is the barrel?',
        checkfill = 'How much % wine is in the barrel?',
        fillheader = 'There is %{value}% wine in this barrel',
        fillbarrel = 'Fill barrel',
        fillbottle = 'Fill bottle',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
