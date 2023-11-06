local Translations = {
    error = {
        alreadybucket = 'Je hebt al een emmer neer gezet..',
        cantplacehere = 'Je kan je vat hier niet plaatsen..',
        tomanybarrels = 'Je hebt al te veel vaten geplaatst!',
        barrelgotbad = 'Je vat is slecht geworden..',
        barrelfull = 'Je vat zit al vol..',
        barrelnotexist = 'Dit vat is niet in gebruik of is geen wijnvat.. (Of loop eens in en uit de zone)',
        barrelempty = 'Dit vat is leeg..',
        missingitem = 'Je mist %{value} keer %{value2}',
        stoppedpluck = 'Gestopt met plukken..',
        stoppedfilling = 'Gestopt met vullen..',
        notowner = 'Je bent niet de eigenaar van dit vat..',
        stoppedsqueeze = 'Je bent gestopt met het pletten van je bessen..',
        toyoungbarrel = 'Je vat is nog te jong..',
    },
    success = {
        filledbarrel = 'Je vat zit nu voor %{value}% vol',
        filledbottle = 'Fles gevuld en nog %{value}% in je vat over',
    },
    info = {
        plucking = 'Bessen aan het plukken..',
        filling = 'Aan het vullen..',
        squeezing = 'Bessen aan het pletten..'
    },
    target = {
        barrel = 'Bekijk vat',
        pluck = 'Pluk besjes',
        squeeze = 'Plet %{value} bessen',
        pickupbucket = 'Pak je emmer op',

    },
    menu = {
        header = '%{value} jaar oud vat',
        checkfillh = 'Hoe vol zit mijn vat?',
        checkfill = 'Hoeveel % wijn zit er al in dit vat?',
        fillheader = 'Er zit %{value}% wijn in je vat',
        fillbarrel = 'Vul je vat',
        fillbottle = 'Vul je wijnfles',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
