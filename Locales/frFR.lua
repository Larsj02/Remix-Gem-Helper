---@class RemixGemHelperPrivate
local Private = select(2, ...)
Private.Locales = Private.Locales or {}

Private.Locales["frFR"] = {
    -- ItemTooltips.lua
    ["Rank"] = "Rang",
    ["Upgradeable"] = "Améliorable",
    ["Not Upgradeable"] = "Non améliorable",

    -- Core.lua
    ["Socketed"] = "Enchâssé",
    ["In Bag"] = "Dans le sac",
    ["In Bag Item!"] = "Objet dans le sac !",
    ["Uncollected"] = "Non collecté",
    ["Scrappable Items"] = "Objets recyclables",
    ["NOTHING TO SCRAP"] = "RIEN À RECYCLER",
    ["Resocket Gems"] = "Ré-enchâsser les gemmes",
    ["Toggle the %s UI"] = "Afficher/Cacher l'interface de %s UI",
    ["Search Gems"] = "Chercher des gemmes",
    ["Unowned"] = "Non possédé",
    ["Show Unowned Gems in the List."] = "Afficher les gemmes non possédées dans la liste.",
    ["Primordial"] = "Primordial",
    ["Show Primordial Gems in the List."] = "Afficher les gemmes primordiales dans la liste.",
    ["Open, Use and Combine"] = "Ouvrir, utiliser et combiner",
    ["NOTHING TO USE"] = "RIEN À UTILISER",
    ["HelpText"] =
        "|A:newplayertutorial-icon-mouse-leftbutton:16:16|a Cliquez sur une gemme dans cette liste pour l'enchâsser ou la désenchâsser.\n" ..
        "'Objet dans le sac' ou 'Enchâssé' indique que vous pouvez la désenchâsser.\n" ..
        "'Dans le sac' indique que la gemme est dans votre sac et est prête à être enchâssée.\n\n" ..
        "En survolant une gemme 'Enchâssée', l'objet sera surligné dans votre panneau de personnage.\n" ..
        "Vous pouvez utiliser le menu déroulant ou la barre de recherche en haut pour filtrer votre liste.\n" ..
        "Cet addon ajoute également le rang actuel et les statistiques de votre cape dans l'infobulle de la cape.\n" ..
        "Vous devriez voir une icône en haut à droite de votre cadre de personnage qui peut être utilisée pour afficher ou masquer ce cadre.\n" ..
        "Sous la liste des gemmes, vous devriez avoir des boutons cliquables pour ouvrir rapidement des coffres ou combiner des gemmes.\n\n" ..
        "Et pour vous débarrasser de ce cadre, il suffit de le cliquer avec la touche Maj enfoncée.\nAmusez-vous bien !",

    -- UIElements.lua
    ["You don't have a valid free Slot for this Gem"] = "Vous n'avez pas d'emplacement libre valide pour cette gemme",
}
