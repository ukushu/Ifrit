import Foundation
@testable import Ifrit

internal struct Book: Searchable {
    let author: String
    let title: String
    
    var properties: [FuseProp] {
        return [
            FuseProp(title, weight: 0.5),
            FuseProp(author, weight: 0.5)
        ]
    }
}

internal struct Anime: Searchable {
    let ukrainian: [String]
    let engOrJap: [String]
    
    var properties: [FuseProp] {
        return ukrainian
                .appending(contentsOf: engOrJap)
                .map{ FuseProp($0) }
    }
}

internal extension Array {
     func appending(contentsOf newItems: [Element]) -> [Element] {
        var temp: [Element] = []
        temp.append(contentsOf: self )
        temp.append(contentsOf: newItems)
        return temp
    }
}

func largeBookTitlesArray(len: Int = 50_000) -> [String] {
    var tmp = booksArray
    
    while tmp.count < len {
        tmp.append(contentsOf: booksArray)
    }
    
    return Array( tmp.dropLast(tmp.count - len) )
}

/// 2471 animes in list
func largeAnimeArray() -> [Anime] {
    return animesList.split(separator: "\n")
                .map{ $0.split(separator: "↑") }
                .map{ $0.map{ $0.split(separator: "|" ).map{ "\($0)" } } }
                .map{ Anime(ukrainian: $0[0], engOrJap: $0[1]) }
}


let booksArray: [String] = """
    Never Let Me Go
    Animal’s People
    The Elegance of the Hedgehog
    Saturday
    Falling Man
    The Children’s Book
    On Beauty
    The Reluctant Fundamentalist
    Invisible
    Slow Man
    Half of a Yellow Sun
    American Rust
    Adjunct: An Undigest
    The Kindly Ones
    Cost: A Novel
    The Sea
    The Inheritance of Loss
    The White Tiger
    The Red Queen
    Against the Day
    Home
    The Plot Against America
    Carry Me Down
    8Kieron Smith, Boy
    The Master
    Mother’s Milk
    The Gathering
    Vanishing Point
    Measuring the World
    The Blind Side Of The Heart
    The Lambs of London
    A Short History of Tractors in Ukrainian
    The Brief Wondrous Life of Oscar Wao
    Dining on Stones
    Cloud Atlas
    The Accidental
    Drop City
    The Line of Beauty
    The Colour
    2666
    Thursbitch
    Small Island
    The Light of Day
    The Book about Blanche and Marie
    What I Loved
    The Curious Incident of the Dog in the Night-Time
    Islands
    Suite Francaise
    Elizabeth Costello
    The Swarm
    London Orbital
    Family Matters
    Your Face Tomorrow
    Fingersmith
    A Tale of Love and Darkness
    The Double
    Everything is Illuminated
    Unless
    Lady Number Thirteen
    Kafka on the Shore
    The Successor
    The Story of Lucy Gault
    Vernon God Little
    That They May Face the Rising Sun
    The Namesake
    In the Forest
    Shroud
    Middlesex
    Youth
    Dead Air
    Snow
    Nowhere Man
    he Book of Illusions
    Gabriel’s Gift
    Austerlitz
    Platform
    Schooling
    Soldiers of Salamis
    Atonement
    I’m Not Scared
    The Corrections
    Don’t Move
    The Amazing Adventures of Kavalier & Clay
    The Body Artist
    Fury
    At Swim, Two Boys
    Choke
    Life of Pi
    The Feast of the Goat
    An Obedient Father
    The Devil and Miss Prym
    Spring Flowers, Spring Frost
    Bartleby and Co.
    White Teeth
    The Heart of Redness
    See under the 1900s
    Under the Skin
    See under the 1900s
    Ignorance
    See under the 1900s
    Nineteen Seventy Seven
    Celestial Harmonies
    City of God
    See under the 1900s
    How the Dead Live
    See under the 1900s
    The Human Stain
    The Blind Assassin
    After the Quake
    See under the 1900s
    Small Remedies
    Super-Cannes
    House of Leaves
    Blonde
    Pastoralia
    See under the 1900s
    The Museum of Unconditional Surrender
    In Search of Klingsor
    Pavel’s Letters
    Savage Detectives
    Dirty Havana Trilogy
    The Heretic
    Crossfire
    Timbuktu
    The Romantics
    Cryptonomicon
    As If I Am Not There
    Money to Burn
    Everything You Need
    Fear and Trembling
    Margot and the Angels
    The Ground Beneath Her Feet
    Disgrace
    Sputnik Sweetheart
    Fall on Your Knees
    Elementary Particles
    A Light Comedy
    Intimacy
    Amsterdam
    Cloudsplitter
    All Souls Day
    The Talk of the Town
    Tipping the Velvet
    The Poisonwood Bible
    Glamorama
    Another World
    The Hours
    Santa Evita
    Veronika Decides to Die
    Mason & Dixon
    The God of Small Things
    Memoirs of a Geisha
    Great Apes
    The Late-Night News
    Enduring Love
    Troubling Love
    Underworld
    Jack Maggs
    The Life of Insects
    Our Lady of Assassins
    American Pastoral
    The Untouchable
    Silk
    Cocaine Nights
    Hallucinating Foucault
    Fugitive Pieces
    The Ghost Road
    Deep River
    Forever a Stranger
    Infinite Jest
    The Clay Machine-Gun
    Waiting for the Dark, Waiting for the Light
    Alias Grace
    The Unconsoled
    Morvern Callar
    The Information
    The Twins
    The Moor’s Last Sigh
    Sabbath’s Theater
    The Rings of Saturn
    The Reader
    A Fine Balance
    Love’s Work
    The Holder of the World
    The End of the Story
    Remembering Babylon
    Mr. Vertigo
    The Adventures and Misadventures of Magroll
    The Folding Star
    Whatever
    Before Night Falls
    Land
    The Master of Petersburg
    The Wind-Up Bird Chronicle
    Uncle Petros and Goldbach’s Conjecture
    Pereira Declares: A Testimony
    The Triple Mirror of the Self
    City Sister Silver
    All the Pretty Horses
    How Late It Was, How Late
    Captain Corelli’s Mandolin
    Felicia’s Journey
    Disappearance
    The Invention of Curried Sausage
    The Shipping News
    The Dumas Club
    Trainspotting
    Birdsong
    Looking for the Possible Dance
    Operation Shylock
    Memoirs of Rain
    Complicity
    On Love
    What a Carve Up!
    A Suitable Boy
    The Stone Diaries
    The Virgin Suicides
    The House of Doctor Dee
    Astradeni
    The Robber Bride
    Faceless Killers
    The Emigrants
    The Laws
    The Secret History
    Life is a Caravanserai
    The Discovery of Heaven
    The Daughter
    A Heart So White
    Possessing the Secret of Joy
    Indigo
    The Crow Road
    Written on the Body
    Jazz
    The English Patient
    The Shadow Lines
    Smilla’s Sense of Snow
    The Butcher Boy
    Black Water
    The Heather Blazing
    Asphodel
    Black Dogs
    Hideous Kinky
    Arcadia
    The Great Indian Novel
    Wild Swans
    American Psycho
    Time’s Arrow
    Mao II
    Typical
    Inland
    Regeneration
    Obabakoak
    Downriver
    Gimmick!
    Señor Vivo and the Coca Lord
    Wise Children
    Paradise of the Blind
    Get Shorty
    Amongst Women
    Vineland
    Vertigo
    Stone Junction
    The Last World
    The Music of Chance
    The First Garden
    The Things They Carried
    A Home at the End of the World
    Like Life
    Possession
    Kitchen
    The Buddha of Suburbia
    The Midnight Examiner
    A Disaffection
    Sexing the Cherry
    Moon Palace
    Black Box
    Billy Bathgate
    Remains of the Day
    All Souls
    The Melancholy of Resistance
    The Temple of My Familiar
    Of Love and Shadows
    The Trick is to Keep Breathing
    The History of the Siege of Lisbon
    Like Water for Chocolate
    A Prayer for Owen Meany
    The Ballad for Georg Henig
    London Fields
    The Book of Evidence
    Cat’s Eye
    Foucault’s Pendulum
    The Beautiful Room is Empty
    Wittgenstein’s Mistress
    Memory of Fire
    The Satanic Verses
    The Swimming-Pool Library
    Oscar and Lucinda
    Libra
    The Player of Games
    The Beautiful Mrs. Seidenman
    Nervous Conditions
    Ancestral Voices
    The Long Dark Teatime of the Soul
    Dirk Gently’s Holistic Detective Agency
    The Radiant Way
    Annie John
    The Afternoon of a Writer
    The Black Dahlia
    Simon and the Oaks
    The Passion
    The Pigeon
    Blood Meridian
    The Child in Time
    Cigarettes
    The Bonfire of the Vanities
    The New York Trilogy
    World’s End
    Half of Man is Woman
    Enigma of Arrival
    The Taebek Mountains
    Love Medicine
    Beloved
    The Young Man
    Anagrams
    Matigari
    Marya
    Watchmen
    The Old Devils
    Lost Language of Cranes
    An Artist of the Floating World
    Extinction
    Democracy
    Foe
    The Drowned and the Saved
    Reasons to Live
    The Parable of the Blind
    Larva: Midsummer Night’s Babel
    Love in the Time of Cholera
    Oranges Are Not the Only Fruit
    Professor Martens’ Departure
    The Cider House Rules
    A Maggot
    Less Than Zero
    Contact
    The Witness
    The Handmaid’s Tale
    Fado Alexandrino
    Perfume
    The Christmas Oratorio
    Old Masters
    White Noise
    Queer
    Hawksmoor
    Legend
    Dictionary of the Khazars
    Baltasar and Blimunda
    The Bus Conductor Hines
    The Book of Diquiet
    The Year of the Death of Ricardo Reis
    The Lover
    Empire of the Sun
    The Wasp Factory
    Nights at the Circus
    The Unbearable Lightness of Being
    Blood and Guts in High School
    Neuromancer
    Flaubert’s Parrot
    Money: A Suicide Note
    Couples, Passerby
    Shame
    Worstward Ho
    Fools of Fortune
    The War at the End of the World
    La Brava
    Leaden Wings
    Waterland
    The House with the Blind Glass Windows
    The Life and Times of Michael K
    The Diary of Jane Somers
    The Piano Teacher
    The Sorrow of Belgium
    If Not Now, When?
    Smell of Sadness
    A Boy’s Own Story
    The Color Purple
    Wittgenstein’s Nephew
    Clear Light of Day
    A Pale View of Hills
    Schindler’s Ark
    Southern Seas
    The House of the Spirits
    The Newton Letter
    Fool’s Gold
    On the Black Hill
    Concrete
    A Dry White Season
    The Names
    Rabbit is Rich
    Lanark: A Life in Four Books
    So Long a Letter
    The Comfort of Strangers
    July’s People
    Summer in Baden-Baden
    Broken April
    Waiting for the Barbarians
    The Back Room
    Midnight’s Children
    Rites of Passage
    Rituals
    Confederacy of Dunces
    Requiem for a Dream
    City Primeval
    The Beggar Maid
    The Name of the Rose
    The Book of Laughter and Forgetting
    Smiley’s People
    Shikasta
    The Wars
    A Bend in the River
    Burger’s Daughter
    The Safety Net
    Quartet in Autumn
    If On a Winter’s Night a Traveler
    The Engineer of Human Souls
    The Hitchhiker’s Guide to the Galaxy
     The Cement Garden
    Almost Transparent Blue
    The World According to Garp
    Kiss of the Spider Woman
    Life: A User’s Manual
    The Sea, The Sea
    The Singapore Grip
    Yes
    Blaming
    The Virgin in the Garden
    In the Heart of the Country
    The Passion of New Eve
    Delta of Venus
    The Shining
    Dispatches
    Petals of Blood
    Song of Solomon
    The Hour of the Star
    Woman at Point Zero
    The Left-Handed Woman
    Ratner’s Star
    The Year of the Hare
    The Public Burning
    The Commandant
    Interview With the Vampire
    Cutter and Bone
    The Port
    Amateurs
    Patterns of Childhood
    Autumn of the Patriarch
    W, or the Memory of Childhood
    The Diviners
    A Dance to the Music of Time
    The Dispossessed
    Grimus
    The Dead Father
    Fateless
    Willard and His Bowling Trophies
    High Rise
    Humboldt’s Gift
    Dead Babies
    Correction
    Ragtime
    The Optimistrist’s Daughter
    The Fan Man
    The Twilight Years
    Dusklands
    The Lost Honor of Katharina Blum
    Tinker Tailor Soldier Spy
    Breakfast of Champions
    Fear of Flying
    A Question of Power
    Lives of Girls & Women
    The Siege of Krishnapur
    The Castle of Crossed Destinies
    Crash
    The Honorary Consul
    Cataract
    Gravity’s Rainbow
    The Black Prince
    Sula
    Invisible Cities
    The Breast
    A World for Julius
    The Summer Book
    G
    Play It As It Lays
    Surfacing
    Fifth Business
    House Mother Normal
    Here’s to You, Jesusa
    In A Free State
    Seasons of Migrations to the North
    The Book of Daniel
    Heartbreak Tango
    Fear and Loathing in Las Vegas
    Moscow Stations
    Group Portrait With Lady
    The Case Worker
    The Wild Boys
    Rabbit Redux
    The Sea of Fertility
    The Driver’s Seat
    The Ogre
    The Bluest Eye
    Jacob the Liar
    Goalie’s Anxiety at the Penalty Kick
    I Know Why the Caged Bird Sings
    Mercier et Camier
    Troubles
    Jahrestage
    The Atrocity Exhibition
    Tent of Miracles
    Pricksongs and Descants
    Blind Man With a Pistol
    Slaughterhouse-five
    The French Lieutenant’s Woman
    The Green Man
    Portnoy’s Complaint
    The Godfather
    Ada
    Them
    The Cathedral
    A Void/Avoid
    Eva Trout
    Myra Breckinridge
    Day of the Dolphin
    The Nice and the Good
    Belle du Seigneur
    Cancer Ward
    The Manor
    The First Circle
    2001: A Space Odyssey
    Z
    Do Androids Dream of Electric Sheep?
    Miramar
    Dark as the Grave Wherein My Friend is Laid
    The German Lesson
    In Watermelon Sugar
    A Kestrel for a Knave
    The Quest for Christa T.
    Chocky
    Marks of Identity
    The Electric Kool-Aid Acid Test
    The Cubs and Other Stories
    One Hundred Years of Solitude
    To Each His Own
    The Master and Margarita
    Silence
    Pilgrimage
    Death and the Dervish
    The Joke
    No Laughing Matter
    The Third Policeman
    A Man Asleep
    Garden, Ashes
    The Birds Fall Down
    Trawl
    Closely Watched Trains
    In Cold Blood
    Back to Oegstgeest
    The Magus
    The Vice-Consul
    Wide Sargasso Sea
    The Three Trapped Tigers
    Giles Goat-Boy
    The Crying of Lot 49
    Things
    The River Between
    August is a Wicked Month
    God Bless You, Mr. Rosewater
    Everything That Rises Must Converge
    The Passion According to G.H.
    Sometimes a Great Notion
    Come Back, Dr. Caligari
    Albert Angelo
    Arrow of God
    Dog Years
    The Ravishing of Lol V. Stein
    The Third Wedding
    Herzog
    V.
    Cat’s Cradle
    The Time of the Hero -Mario Vargas Llosa
    The Graduate
    The Death of Artemio Cruz
    Manon des Sources
    The Spy Who Came in from the Cold
    The Girls of Slender Means
    Inside Mr. Enderby
    The Bell Jar
    Time of Silence
    One Day in the Life of Ivan Denisovich
    The Collector
    One Flew Over the Cuckoo’s Nest
    A Clockwork Orange
    Memoirs of a Peasant Boy
    Pale Fire
    The Drowned World
    No One Writes to the Colonel
    The Golden Notebook
    Labyrinths
    Girl With Green Eyes
    The Garden of the Finzi-Continis
    Stranger in a Strange Land
    Franny and Zooey
    A Severed Head
    The Shipyard
    Faces in the Water
    God’s Bits of Wood
    Solaris
    Bebo’s Girl
    Cat and Mouse
    The Prime of Miss Jean Brodie
    Halftime
    Catch-22
    The Magician of Lublin
    The Violent Bear it Away
    How It Is
    Our Ancestors
    The Country Girls
    To Kill a Mockingbird
    Rabbit, Run
    Promise at Dawn
    Cider With Rosie
    Billy Liar
    Down Second Avenue
    Naked Lunch
    The Tin Drum
    Absolute Beginners
    Henderson the Rain King
    Deep Rivers
    Memento Mori
    Billiards at Half-Past Nine
    The Guide
    Breakfast at Tiffany’s
    The Leopard
    Pluck the Bud and Destroy the Offspring
    A Town Like Alice
    Gabriela, Clove and Cinnamon
    The Bitter Glass
    Things Fall Apart
    Saturday Night and Sunday Morning
    Mrs. ‘Arris Goes to Paris
    The Birds
    Borstal Boy
    The End of the Road
    The Once and Future King
    The Bell
    Jealousy
    Voss
    The Deadbeats
    The Midwich Cuckoos
    The Manila Rope
    Blue Noon
    Homo Faber
    On the Road
    Pnin
    The Glass Bees
    Doctor Zhivago
    The Wonderful “O”
    Justine
    Giovanni’s Room
    The Lonely Londoners
    The Roots of Heaven
    Seize the Day
    The Floating Opera
    The Lord of the Rings
    The Devil to Pay in the Backlands
    The Talented Mr. Ripley
    Lolita
    The Tree of Man
    A World of Love
    The Trusting and the Maimed
    The Quiet American
    The Burning Plain
    The Last Temptation of Christ
    The Recognitions
    The Ragazzi
    Bonjour Tristesse
    The Unknown Soldier
    I’m Not Stiller
    The Sound of Waves
    Self Condemned
    Death in Rome
    The Story of O
    A Ghost at Noon
    The Mandarins
    Lord of the Flies
    Under the Net
    The Go-Between
    The Long Goodbye
    The Unnamable
    A Day in Spring
    Watt
    The Dark Child
    Lucky Jim
    Junkie
    The Adventures of Augie March
    The Hothouse
    Go Tell It on the Mountain
    The Lost Steps
    Casino Royale
    The Judge and His Hangman
    Invisible Man
    The Old Man and the Sea
    Wise Blood
    A Thousand Cranes
    The Killer Inside Me
    Excellent Women
    Memoirs of Hadrian
    Malone Dies
    The Day of the Triffids
    Foundation
    The Opposing Shore
    The Hive
    The Catcher in the Rye
    The Rebel
    Molloy
    The End of the Affair
    The Abbot C
    The Labyrinth of Solitude
    The Third Man
    The 13 Clocks
    Gormenghast
    The Grass is Singing
    Barabbas
    I, Robot
    The Guiltless
    The Moon and the Bonfires
    The Garden Where the Brass Band Played
    Love in a Cold Climate
    The Case of Comrade Tulayev
    The Heat of the Day
    Kingdom of This World
    The Man With the Golden Arm
    Nineteen Eighty-Four
    All About H. Hatterr
    Disobedience
    Death Sentence
    The Heart of the Matter
    Cry, the Beloved Country
    Doctor Faustus
    The Victim
    Exercises in Style
    If This Is a Man
    The Way for the Gas, Ladies and Gentlemen
    Under the Volcano
    In The Heart of the Seas
    The Path to the Nest of Spiders
    The Plague
    Back
    Titus Groan
    Ashes and Diamonds
    The Bridge on the Drina
    Journey to the Alcarria
    Brideshead Revisited
    Froth on the Daydream
    Animal Farm
    Midaq Alley
    Cannery Row
    The Pursuit of Love
    Loving
    Arcanum 17
    Christ Stopped at Eboli
    The Razor’s Edge
    Transit
    House in the Uplands
    Ficciones
    Dangling Man
    Zorba the Greek
    The Little Prince
    Caught
    The Death of Virgil
    The Glass Bead Game
    Andrea
    Embers
    The Tin Flute
    Go Down, Moses
    Bosnian Chronicle
    The Outsider
    In Sicily
    The Poor Mouth
    The Living and the Dead
    Hangover Square
    Between the Acts
    The Hamlet
    Pippi Longstocking
    Farewell My Lovely
    For Whom the Bell Tolls
    Native Son
    The Power and the Glory
    The Tartar Steppe
    Joseph and His Brothers
    Party Going
    The Grapes of Wrath
    Chess Story
    Finnegans Wake
    At Swim-Two-Birds
    Coming Up for Air
    Goodbye to Berlin
    The Harvesters
    Tropic of Capricorn
    Good Morning, Midnight
    Broad and Aliens is the World
    The Big Sleep
    The Man Who Loved Children
    After the Death of Don Juan
    Miss Pettigrew Lives for a Day
    Nausea
    Rebecca
    Cause for Alarm
    Brighton Rock
    U.S.
    Murphy
    Of Mice and Men
    Their Eyes Were Watching God
    The Hobbit
    On the Edge of Reason
    The Years
    In Parenthesis
    The Revenge for Love
    Out of Africa
    Alamut
    To Have and Have Not
    Summer Will Show
    Eyeless in Gaza
    The Thinking Reed
    Gone With the Wind
    Keep the Aspidistra Flying
    Wild Harbour
    Absalom, Absalom!
    The Blind Owl
    At the Mountains of Madness
    Ferdydurke
    Nightwood
    Independent People
    Auto-da-Fé
    Rickshaw Boy
    The Last of Mr. Norris
    They Shoot Horses, Don’t They?
    The House in Paris
    England Made Me
    Burmese Days
    The Nine Tailors
    War with the Newts
    Threepenny Novel
    Novel With Cocaine
    The Postman Always Rings Twice
    Tropic of Cancer
    A Handful of Dust
    Untouchable
    Tender is the Night
    Thank You, Jeeves
    Call it Sleep
    Miss Lonelyhearts
    Murder Must Advertise
    The Bells of Basel
    The Autobiography of Alice Toklas
    On the Heights of Despair
    Testament of Youth
    A Day Off
    The Man Without Qualities
    A Scots Quair (Sunset Song)
    Journey to the End of the Night
    The Street of Crocodiles
    Brave New World
    Cold Comfort Farm
    To the North
    The Thin Man
    The Radetzky March
    The Waves
    The Glass Key
    Man’s Fate
    Cakes and Ale
    Cheese
    The Apes of God
    Her Privates We
    Vipers’ Tangle
    Vile Bodies
    The Maltese Falcon
    Hebdomeros
    The Forbidden Realm
    Passing
    A Farewell to Arms
    The Return of Philip Latinowicz
    Red Harvest
    Living
    The Time of Indifference
    All Quiet on the Western Front
    Berlin Alexanderplatz
    Insatiability
    The Last September
    Monica
    Harriet Hume
    The Sound and the Fury
    Les Enfants Terribles
    Look Homeward, Angel
    Story of the Eye
    Orlando
    Lady Chatterley’s Lover
    I Thought of Daisy
    The Well of Loneliness
    The Childermass
    Quartet
    Decline and Fall
    Quicksand
    Parade’s End
    Retreat Without Song
    Nadja
    Steppenwolf
    Remembrance of Things Past
    To The Lighthouse
    Tarka the Otter
    Amerika
    Some Prefer Nettles
    The Sun Also Rises
    Blindness
    The Castle
    The Good Soldier Švejk
    The Plumed Serpent
    One, None and a Hundred Thousand
    The Murder of Roger Ackroyd
    The Making of Americans
    The Case of Sergeant Grischa
    Manhattan Transfer
    Mrs. Dalloway
    The Great Gatsby
    The Counterfeiters
    The Trial
    Alberta and Jacob
    The Artamonov Business
    The Professor’s House
    Under Satan’s Sun
    Billy Budd, Foretopman
    The Green Hat
    The Magic Mountain
    We
    Chaka the Zulu
    A Passage to India
    The Devil in the Flesh
    Zeno’s Conscience
    Cane
    Antic Hay
    Amok
    The Garden Party
    The New World
    The Enormous Room
    Jacob’s Room
    Siddhartha
    The Glimpses of the Moon
    Life and Death of Harriett Frean
    The Last Days of Humanity
    Aaron’s Rod
    Babbitt
    Kristin Lavransdatter
    Ulysses
    The Fox
    Crome Yellow
    The Forest of the Hanged
    The Age of Innocence
    Main Street
    Claudine’s House
    Women in Love
    Night and Day
    Tarr
    Life of Christ
    The Return of the Soldier
    The Shadow Line
    Summer
    Growth of the Soil
    Bunner Sisters
    The Storm of Steel
    A Portrait of the Artist as a Young Man
    Under Fire
    Rashomon
    The Good Soldier
    Home and the World
    The Voyage Out
    Pallieter
    Of Human Bondage
    The Underdogs
    The Rainbow
    The Thirty-Nine Steps
    Kokoro
    Locus Solus
    Rosshalde
    Tarzan of the Apes
    The Ragged Trousered Philanthropists
    Sons and Lovers
    Death in Venice
    The Charwoman’s Daughter
    Ethan Frome
    Platero and I
    Fantômas
    Howards End
    Impressions of Africa
    Three Lives
    Martin Eden
    Strait is the Gate
    Tono-Bungay
    The Inferno
    A Room With a View
    The Notebooks of Malte Laurids Brigge
    The Iron Heel
    The Old Wives’ Tale
    The House on the Borderland
    Mother
    The Secret Agent
    The Jungle
    Young Törless
    The Forsyte Sage
    The House of Mirth
    Professor Unrat
    Where Angels Fear to Tread
    Nostromo
    Hadrian the Seventh
    The Golden Bowl
    The Ambassadors
    The Riddle of the Sands
    The Way of All Flesh
    The Immoralist
    Memoirs of my Nervous Illness
    The Wings of the Dove
    The Call of the Wild
    Heart of Darkness
    The Hound of the Baskervilles
    Buddenbrooks
    Kim
    Sister Carrie
    Lord Jim
    None but the Brave
    Some Experiences of an Irish R.M.
    The Stechlin
    The Awakening
    See last entry in 1900s.
    The Turn of the Screw
    The War of the Worlds
    Sandokan: The Tigers of Mompracem
    The Invisible Man
    What Maisie Knew
    Eclipse of the Crescent Moon
    Fruits of the Earth
    Dracula
    Quo Vadis
    Dom Casmurro
    The Island of Dr. Moreau
    As a Man Grows Older
    The Time Machine
    Effi Briest
    Jude the Obscure
    Pharoah
    The Real Charlotte
    Compassion
    The Yellow Wallpaper
    Born in Exile
    Diary of a Nobody
    The Adventures of Sherlock Holmes
    News from Nowhere
    New Grub Street
    Gösta Berling’s Saga
    Tess of the D’Urbervilles
    The Viceroys
    The Picture of Dorian Gray
    The Kreutzer Sonata
    La Bête Humaine
    By the Open Sea
    Hunger
    The Master of Ballantrae
    Pierre and Jean
    Down There
    Fortunata and Jacinta
    The People of Hemsö
    The Woodlanders
    Thais
    She
    The Strange Case of Dr. Jekyll and Mr. Hyde
    The Mayor of Casterbridge
    Kidnapped
    Eline Vere
    King Solomon’s Mines
    The Child of Pleasure
    Germinal
    Under the Yoke
    The Adventures of Huckleberry Finn
    Bel-Ami
    Marius the Epicurean
    The Manors of Ulloa
    Against the Grain
    The Death of Ivan Ilyich
    The Quest
    A Woman’s Life
    Treasure Island
    The House by the Medlar Tree
    The Portrait of a Lady
    Bouvard and Pécuchet
    Ben-Hur
    The Regent’s Wife
    Nana
    The Brothers Karamazov
    The Red Room
    Return of the Native
    Anna Karenina
    Drunkard
    The Posthumous Memoirs of Bras Cubas
    Virgin Soil
    Daniel Deronda
    The Hand of Ethelberta
    The Temptation of Saint Anthony
    Far from the Madding Crowd
    The Enchanted Wanderer
    Martin Fierro
    Around the World in Eighty Days
    In a Glass Darkly
    The Devils
    The Crime of Father Amado
    Erewhon
    Pepita Jimenez
    Spring Torrents
    Middlemarch
    Through the Looking Glass, and What Alice Found There
    King Lear of the Steppes
    He Knew He Was Right
    War and Peace
    Sentimental Education
    Phineas Finn
    Maldoror
    The Idiot
    The Moonstone
    Little Women
    Thérèse Raquin
    The Last Chronicle of Barset
    Journey to the Centre of the Earth
    Crime and Punishment
    Alice’s Adventures in Wonderland
    Our Mutual Friend
    Uncle Silas
    Notes from the Underground
    The Water-Babies
    Les Misérables
    Fathers and Sons
    Silas Marner
    Great Expectations
    On the Eve
    Castle Richmond
    The Mill on the Floss
    The Woman in White
    The Marble Faun
    Max Havelaar
    A Tale of Two Cities
    Oblomovka
    Adam Bede
    Madame Bovary
    Indian Summer
    North and South
    Hard Times
    Walden
    Green Henry
    Bleak House
    Villette
    Cranford
    Uncle Tom’s Cabin; or, Life Among the Lonely
    The Blithedale Romance
    The House of the Seven Gables
    Moby-Dick
    The Scarlet Letter
    David Copperfield
    Shirley
    Mary Barton
    The Tenant of Wildfell Hall
    Wuthering Heights
    Agnes Grey
    The Devil’s Pool
    Jane Eyre
    Facundo
    Vanity Fair
    The Count of Monte-Cristo
    La Reine Margot
    The Three Musketeers
    The Purloined Letter
    A Hero of Our Times
    Martin Chuzzlewit
    Camera Obscura
    The Pit and the Pendulum
    Lost Illusions
    A Christmas Carol
    The Lion of Flanders
    Dead Souls
    The Charterhouse of Parma
    The Fall of the House of Usher
    The Life and Adventures of Nicholas Nickleby
    Oliver Twist
    Eugene Onegin
    The Nose
    Le Père Goriot
    Eugénie Grandet
    The Hunchback of Notre Dame
    The Red and the Black
    The Life of a Good-for-Nothing
    The Betrothed
    Last of the Mohicans
    The Life and Opinions of the Tomcat Murr
    The Private Memoirs and Confessions of a Justified Sinner
    The Albigenses
    Melmoth the Wanderer
    The Monastery
    Ivanhoe
    Frankenstein
    Northanger Abbey
    Persuasion
    Ormond
    Michael Kohlhaas
    Rob Roy
    Emma
    Henry of Ofterdingen
    Mansfield Park
    Pride and Prejudice
    The Absentee
    Sense and Sensibility
    Elective Affinities
    Castle Rackrent
    Hyperion
    The Nun
    Camilla
    The Monk
    Wilhelm Meister’s Apprenticeship
    The Mysteries of Udolpho
    A Dream of Red Mansions
    The Interesting Narrative
    The Adventures of Caleb Williams
    Justine
    Anton Reiser
    Vathek
    The 120 Days of Sodom
    Cecilia
    Confessions
    Dangerous Liaisons
    Reveries of a Solitary Walker
    Evelina
    The Sorrows of Young Werther
    Humphrey Clinker
    The Man of Feeling
    A Sentimental Journey
    Tristram Shandy
    The Vicar of Wakefield
    The Castle of Otranto
    Émile; or, On Education
    Rameau’s Nephew
    Julie; or, the New Eloise
    Rasselas
    Candide
    The Female Quixote
    Amelia
    Peregrine Pickle
    Fanny Hill
    Tom Jones
    Roderick Random
    Clarissa
    Pamela
    Jacques the Fatalist
    Memoirs of Martinus Scriblerus
    Joseph Andrews
    A Modest Proposal
    Gulliver’s Travels
    The Adventurous Simplicissimus
    Roxana
    The Conquest of New Spain
    Moll Flanders
    See Pre-1700s
    Love in Excess
    Robinson Crusoe
    See Pre-1700s
    A Tale of a Tub
    The Travels of Persiles and Sigismunda
    Thomas of Reading
    Oroonoko
    Monkey: A Journey to the West
    The Princess of Clèves
    The Lusiad
    The Pilgrim’s Progress
    Don Quixote
    The Life of Lazarillo de Tormes
    The Unfortunate Traveller
    Amadis of Gaul
    Euphues: The Anatomy of Wit
    La Celestina
    Gargantua and Pantagruel
    Tirant lo Blanc
    The Thousand and One Nights
    The Golden Ass
    The Water Margin
    Aithiopika
    Romance of the Three Kingdoms
    Chaireas and Kallirhoe
    The Tale of Genji
    Metamorphoses
    The Tale of the Bamboo Cutter
    Aesop’s Fables
    School
    Who am I?
    Big and Little
    I Can See
    I Can, We Can
    Hats
    Kittens
    Lunch
    We are Painting
    What Am I?
    Apples
    Boots
    Car Wash Kid
    Catch the Cat
    I Like Shapes
    I Need a Little Help
    My Cat Muffin
    Swing Swing Swing
    We Like to Play
    What Can I Be?
    Where Do Insects Live?
    Big and Small
    Butterfly
    Is It Time?
    New Roof
    Noisy Breakfast
    Old Mo
    Bears Bears Everywhere
    A Box Can Be Many Things
    Bubble Trouble
    Fresh Autumn Leaves
    The Haircut
    I am the Artist!
    I Do Not Want To
    I Like Shoes
    Just Like Me
    Lara Ladybug
    The Lost Hat
    Not Enough Water
    Rosa Loves to Read
    A Tooth Is Loose
    What Comes in a Shell
    Work and Play
    Beautiful Bugs
    Germs
    Please, Wind?
    A Tree Can Be
    Water Everywhere!
    Grandpa's Quilt
    Hurry Up!
    Kites
    Animal Homes
    Big Machines
    Open Wide
    Whoops!
    One Happy Classroom
    Too Many Balloons
    Who is Getting Married?
    Are We There Yet?
    The Best Mud Pie
    Hello Doctor
    Kim's Trip to Hawaii
    Luna the Wake-Up Cat
    Next to an Ant
    Rainy-Day Music
    Wrinkles
    A Circle in the Sky
    Feeding the Gulls
    Harry's House
    How Does Your Salad Grow?
    Martina the Cockroach
    Shine, Sun!
    Sir Mike
    Two Feet Up, Two Feet Down
    Up, Up, and Away: The Story of Amelia Earhart
    Who Do I Look Like?
    Addition Annie
    Katie Did It
    Rude Ralph
    The Secret Code
    All About Light
    All About Sound
    Always Be Safe
    The Boy Who Cried Wolf
    Generous Me
    Listen to Me
    The Tortoise and the Hare
    Unusual Show
    The Very Big Potato
    The Birthday Party
    The Elves and the Shoemaker
    Food Court
    Goldilocks and the Three Bears
    The Lion's Song
    The Mural
    So Many Me's
    On the Lake
    The Blue Mittens
    Penguins
    A Wise Wish
    Collecting
    Don't Be Late
    I Love Mud and Mud Loves Me
    The Little Red Hen
    Paper Bag Trail
    Rainy Day Alphabet Book
    Elliot Drives Away
    I'll Do It Later
    It's a Good Thing There are
    Insects
    Peanut Butter Rhino
    The Spider and the Beehive
    Stone Soup
    The Three Billy Goats Gruff
    The Ugly Duckling
    Vegetables, Vegetables!
    Who Needs Friends?
    Amazon Sun, Amazon Rain
    Flies Are Fascinating
    Patterns Everywhere
    The Princess and the Pea
    The Showdown
    Take Care of Your Teeth
    Beavers
    Busy, Buzzy Bees
    Cinderella
    Little Koel Finds His Song
    The Night Sky
    The Nightingale
    Odd and Even Socks
    Part of the Pack
    Wax Man
    Where do Puddles Go?
    Who Wants a Ride?
    Hellen Keller
    Inside an Ant Colony
    Log Hotel
    Not for Me
    Sea Slug and Mr. Pelican
    The Tortoise and the Hare
    Amalia and the Grasshopper
    Little One Inch
    The Treasure Hunt
    Eye Foolers
    Rain Forest
    Science Fair Friends
    The Sun's Family of Planets
    Fire and Wind
    Turtles Take Their Time
    Under the City
    Hawks on the Clock
    Anne of Green Gables
    Allergies
    Journey to the Center of the Earth
    Ramadan
    Tricky Rabbit
    What Magnets Can do
    Antarctica
    Ant Attack!
    Curse of the Jungle Treasure
    Earth is Mostly Ocean, The
    Mookie is Missing!
    This Odd House
    Tiny Turtle Wants a Friend
    Animals of Long Ago
    Endangered Animals
    Tortoise Shell and Other African Stories, The
    Drum Beats
    Drum Beats On, The
    Riding Lessons
    You Are the Boss!
    20,000 Leagues Under the Sea
    Africa
    Asia
    Australia and Oceana
    Button Your Lip (and Other Idioms)
    Europe
    North America
    Sir Arthur
    South America
    Treasure Island
    What a Great Idea!
    Bird with Two Heads, The
    Five Snakes, The
    From Zero to Hero
    Golden Touch and Other Greek Myths
    Helen Keller, Girl of Courage
    Jet Packs and Other Groovey Gadgets
    King Arthur
    Man in a Box: A Slave's Escape
    Samurai Fighters
    Tom Sawyer
    Witch Hunt
    Crocodile Tales
    Demeter and Persephone
    Elizabeth Blackwell, First Woman Doctor
    Frankenstein
    Songs My Granda Sang
    War of the Worlds
    First on the Moon
    News and Chews
    Red-Headed League, The
    Myths From Around the World
    3 Thrillers From Poe
    Beluga Whales
    Robinson Crusoe
    African Animals
    Alligators and Crocodiles
    Elephants
    Secrets of Old Hanson House
    Tigers
    Zebras
    Louis Braille: Boy Who Invented the Books
    for the Blind
    That's Science? Bad Hair Days and Other
    Experiments
    Amelia Earhart, Adventure In The Sky
    Growing Crystals
    Gymnastics
    Creatures Infest Local School!
    Black Holes
    Constellations
    Galaxies
    Last Leaf, The
    Meteor Showers
    Mystery of the Spotted Band
    Solar System, The
    Stars
    Sweater Thief, The
    Amazon, The
    Answer Girl Answers Your Questions About
    the Human Body
    Arabian Nights
    Sharks and Rays
    Underground Railroad
    Ancient Maya, The
    Battle of the Bands
    Black Beauty (Junior Classic)
    David Copperfield
    Dr. Jekyll and Mr. Hyde
    Gulliver's Travels
    Here Comes the Judge
    Lucky to be Alive
    Moby Dick
    Saving the Animals
    Albert Einstein: Creative Genius
    Aztec Treasure Hunt
    Classic Tales Of Terror
    False! Popular Myths Debunked
    Favourite Funny Poems
    Great Explorations
    Invisible Man
    Odyssey, The
    Urban Legends (previously published as The Killer Hairdo)
    A Feel Better Book for Littler Worriers
    ABCs of Kindness
    All Are Welcome
    Baby Be Kind
    Be Kind
    Buddy the Bulldozer Learns to Calm Down
    Calm Down Time
    Can I Play Too?
    Can You Make a Happy Face
    Eyes That Kiss in the Comers
    Families
    Hair Love
    Happy Hippo, Angry Duck
    How do I feel? A book about emotions
    How Full is Your Bucket? For Kids
    If You're Happy and You Know It!
    I'm Happy Sad Today
    In My Heart: A Book of Feelings
    It Will Be Okay
    Jabari Jumps
    Join in and Play
    Julián is a Mermaid
    Language That We All Can Speak
    Little Fox Has Feelings
    Meesha Makes Friends
    Meeting Mimi: A Story About Different Abilities
    On Monday When It Rained
    Poor Little Rabbit
    Remarkably YOU
    Rex Wrecks It!
    Roaring Mad Riley
    Stella Brings the Family
    Strictly No Elephants
    The Colors of Us
    The Feelings Book
    The Kissing Hand
    The Many Colors of Harpreet Singh
    The Pout Pout Fish and the Ma Mad Day
    Together We Can
    What If I Know My Feelings?
    When I Am/Cuando Estoy
    When We Are Kind
    You Are a Lion! And Other Fun
    Yoga Poses
    Harry Potter and the Philosopher's Stone, J.K. Rowling, FANTASY, Good
    Harry Potter and the Chamber of Secrets, J.K. Rowling, FANTASY, Fair
    Harry Potter and the Prisoner of Azkaban, J.K. Rowling, FANTASY, New
    Harry Potter and the Goblet of Fire, J.K. Rowling, FANTASY, Good
    Harry Potter and the Order of the Phoenix, J.K. Rowling, FANTASY, Excellent
    Harry Potter and the Half-Blood Prince, J.K. Rowling, FANTASY, New
    Harry Potter and the Deathly Hallows, J.K. Rowling, FANTASY, Bad
    Jenney's Second Year Latin, Charles Jenney Jr., TEXTBOOK, Fair
    Physics: The Physical Setting, Landa & Kiefer, TEXTBOOK, Poor
    Moby Dick, Herman Melville, FICTION, Fair
    Go Set A Watchman, Harper Lee, FICTION, New
    To Kill A Mockingbird, Harper Lee, FICTION, Fair
    Mythology, Edith Hamilton, CLASSICS, Poor
    Animal Farm, George Orwell, FICTION, Excellent
    American History: A Survey, Brinkley, TEXTBOOK, Bad
    The History of the Decline and Fall of the Roman Empire by Edward Gibbon (
    The History of Human Marriage by Edward Westermarck
    The Satires of Juvenal, Persius, Sulpicia, and Lucilius by Juvenal
    History of the Decline and Fall of the Roman Empire — Volume 1 by Edward Gibbon)
    Frankenstein; Or, The Modern Prometheus by Mary Wollstonecraft Shelley
    Romeo and Juliet by William Shakespeare
    Moby Dick; Or, The Whale by Herman Melville
    Pride and Prejudice by Jane Austen
    Middlemarch by George Eliot
    A Room with a View by E. M. Forster
    The Complete Works of William Shakespeare by William Shakespeare
    Little Women; Or, Meg, Jo, Beth, and Amy by Louisa May Alcott
    The Blue Castle: a novel by L. M. Montgomery
    The Enchanted April by Elizabeth Von Arnim
    Antiquities of the Jews by Flavius Josephus
    Forty-one years in India: from subaltern to commander-in-chief by Roberts
    The Adventures of Ferdinand Count Fathom — Complete by T. Smollett
    Spenser's The Faerie Queene, Book I by Edmund Spenser
    Cranford by Elizabeth Cleghorn Gaskell
    The Adventures of Roderick Random by T. Smollett
    The Expedition of Humphry Clinker by T. Smollett
    Twenty years after by Alexandre Dumas and Auguste Maquet
    History of Tom Jones, a Foundling by Henry Fielding
    Pascal's Pensées by Blaise Pascal
    My Life — Volume 1 by Richard Wagner
    Alice's Adventures in Wonderland by Lewis Carroll
    The treatise of Lorenzo Valla on the Donation of Constantine by Lorenzo Valla
    Nieuw volledig Oost-Indisch kookboek by J. M. J. Catenius-van der Meijden
    The guide for the perplexed by Moses Maimonides
    The Social Cancer: A Complete English Version of Noli Me Tangere by José Rizal
    A Doll's House : a play by Henrik Ibsen
    All About Coffee by William H. Ukers
    Revelations of Divine Love
    The Great Gatsby by F. Scott Fitzgerald
    Tom Brown at Rugby by Thomas Hughes
    Beauty contest? by Henry Slesar
    The Importance of Being Earnest: A Trivial Comedy for Serious People by Oscar W828)
    The Picture of Dorian Gray by Oscar Wilde
    Crime and Punishment by Fyodor Dostoyevsky
    A Tale of Two Cities by Charles Dickens
    Metamorphosis by Franz Kafka
    A Christmas Carol in Prose; Being a Ghost Story of Christmas by Charles Dickens
    Dracula by Bram Stoker
    Scotland in Pagan Times; The Iron Age by Joseph Anderson
    The crow's-nest by Sara Jeannette Duncan
    The Strange Case of Dr. Jekyll and Mr. Hyde by Robert Louis Stevenson
    Plain Facts for Old and Young by John Harvey Kellogg
    Adventures of Huckleberry Finn by Mark Twain
    Great Expectations by Charles Dickens
    An enemy of peace by Robert Silverberg
    Der Struwwelpeter by Heinrich Hoffmann
    History of the Royal Regiment of Artillery Vol. 2 by Francis Duncan
    "Everyman," with other interludes, including eight miracle plays
    The Odyssey by Homer
    The Goslings: A Study of the American Schools by Upton Sinclair
    A Modest Proposal by Jonathan Swift
    Grimms' Fairy Tales by Jacob Grimm and Wilhelm Grimm
    Problems in Greek history by J. P. Mahaffy
    Don Quijote by Miguel de Cervantes Saavedra
    The Adventures of Tom Sawyer, Complete by Mark Twain
    The Prince by Niccolò Machiavelli
    The Yellow Wallpaper by Charlotte Perkins Gilman
    The Brothers Karamazov by Fyodor Dostoyevsky
    The Puppet Show of Memory by Maurice Baring
    The Organism as a Whole, from a Physicochemical Viewpoint by Jacques Loeb
    The Adventures of Sherlock Holmes by Arthur Conan Doyle
    The Kama Sutra of Vatsyayana by Vatsyayana
    Jane Eyre: An Autobiography by Charlotte Brontë
    The Philippines a Century Hence by José Rizal
    The Scarlet Letter by Nathaniel Hawthorne
    Loyola and the Educational System of the Jesuits by Thomas Hughes
    Experiments on Animals by Stephen Paget
    The Iliad by Homer
    Stories and Ballads of the Far Past by Nora K. Chadwick
    History of the Royal Regiment of Artillery, Vol. 1 by Francis Duncan
    Heart of Darkness by Joseph Conrad
    The A.B.-Z. of our own nutrition by Horace Fletcher
    Introduction to the science of language, Volume 1 (of 2) by A. H. Sayce
    Aesop's Fables by Aesop
    War and Peace by graf Leo Tolstoy
    Ulysses by James Joyce
    The Architecture of Colonial America by Harold Donaldson Eberlein
    Noli Me Tangere by José Rizal
    Thus Spake Zarathustra: A Book for All and None by Friedrich Wilhelm Nietzsche
    The Count of Monte Cristo by Alexandre Dumas and Auguste Maquet
    The 2005 CIA World Factbook by United States. Central Intelligence Agency
    The Bible: I. Authenticity II. Credibility III. Morality by John E. Remsburg
    Hoyle's Games Modernized by Professor Hoffmann and Edmond Hoyle
    Tractatus Logico-Philosophicus by Ludwig Wittgenstein
    Audubon and His Journals, Volume 2 by John James Audubon
    Wuthering Heights by Emily Brontë
    The Bird Book by Chester A. Reed
    Biddy and the silver man by Harlan Ellison
    Oliver Twist by Charles Dickens
    Don Quixote by Miguel de Cervantes Saavedra
    Meditations by Emperor of Rome Marcus Aurelius
    Walden, and On The Duty Of Civil Disobedience by Henry David Thoreau
    Ang "Filibusterismo" (Karugtóng ng Noli Me Tangere) by José Rizal
    The Romance of Lust: A classic Victorian erotic novel by Anonymous
    Peter Pan by J. M. Barrie
    Frankenstein; Or, The Modern Prometheus by Mary Wollstonecraft Shelley
    Pride and Prejudice by Jane Austen
    Moby Dick; Or, The Whale by Herman Melville
    Romeo and Juliet by William Shakespeare
    Middlemarch by George Eliot
    A Room with a View by E. M. Forster
    The Complete Works of William Shakespeare by William Shakespeare
    Little Women; Or, Meg, Jo, Beth, and Amy by Louisa May Alcott
    The Enchanted April by Elizabeth Von Arnim
    The Blue Castle: a novel by L. M. Montgomery
    The Adventures of Ferdinand Count Fathom — Complete by T. Smollett
    Cranford by Elizabeth Cleghorn Gaskell
    Alice's Adventures in Wonderland by Lewis Carroll
    The Adventures of Roderick Random by T. Smollett
    The Expedition of Humphry Clinker by T. Smollett
    History of Tom Jones, a Foundling by Henry Fielding
    Twenty years after by Alexandre Dumas and Auguste Maquet
    My Life — Volume 1 by Richard Wagner
    A Doll's House : a play by Henrik Ibsen
    The Importance of Being Earnest: A Trivial Comedy for Serious People by Oscar Wilde
    The Great Gatsby by F. Scott Fitzgerald
    The History of the Decline and Fall of the Roman Empire by Edward Gibbon
    Metamorphosis by Franz Kafka
    The Picture of Dorian Gray by Oscar Wilde
    A Tale of Two Cities by Charles Dickens
    Crime and Punishment by Fyodor Dostoyevsky
    Dracula by Bram Stoker
    The Yellow Wallpaper by Charlotte Perkins Gilman
    The Strange Case of Dr. Jekyll and Mr. Hyde by Robert Louis Stevenson
    Ang "Filibusterismo" (Karugtóng ng Noli Me Tangere) by José Rizal
    Noli Me Tangere by José Rizal
    Great Expectations by Charles Dickens
    A Modest Proposal by Jonathan Swift
    Adventures of Huckleberry Finn by Mark Twain
    The Brothers Karamazov by Fyodor Dostoyevsky
    Jane Eyre: An Autobiography by Charlotte Brontë
    The Scarlet Letter by Nathaniel Hawthorne
    The Reign of Greed by José Rizal
    Heart of Darkness by Joseph Conrad
    Don Quijote by Miguel de Cervantes Saavedra
    A Christmas Carol in Prose; Being a Ghost Story of Christmas by Charles Dickens
    The Adventures of Sherlock Holmes by Arthur Conan Doyle
    Grimms' Fairy Tales by Jacob Grimm and Wilhelm Grimm
    The Odyssey by Homer
    Ulysses by James Joyce
    Tractatus Logico-Philosophicus by Ludwig Wittgenstein
    The Iliad by Homer
    War and Peace by graf Leo Tolstoy
    The Kama Sutra of Vatsyayana by Vatsyayana
    The Philippines a Century Hence by José Rizal
    The Prince by Niccolò Machiavelli
    The Souls of Black Folk by W. E. B. Du Bois
    The Geography of Strabo, Volume 1 (of 3) by Strabo
    Wuthering Heights by Emily Brontë
    Thus Spake Zarathustra: A Book for All and None by Friedrich Wilhelm Nietzsche
    The Adventures of Tom Sawyer, Complete by Mark Twain
    Don Quixote by Miguel de Cervantes Saavedra
    A Short History of Freethought Ancient and Modern, Volume 1 of 2 by J. M. Robertson
    Dubliners by James Joyce
    The Romance of Lust: A classic Victorian erotic novel by Anonymous
    The Count of Monte Cristo by Alexandre Dumas and Auguste Maquet
    Treasure Island by Robert Louis Stevenson
    Anne of Green Gables by L. M. Montgomery
    Winnie-the-Pooh by A. A. Milne
    Little Women by Louisa May Alcott
    Peter Pan by J. M. Barrie
    The divine comedy by Dante Alighieri
    Calculus Made Easy by Silvanus P. Thompson
    The Hound of the Baskervilles by Arthur Conan Doyle
    Walden, and On The Duty Of Civil Disobedience by Henry David Thoreau
    The Wonderful Wizard of Oz by L. Frank Baum
    Leviathan by Thomas Hobbes
    Beyond Good and Evil by Friedrich Wilhelm Nietzsche
    The War of the Worlds by H. G. Wells
    A Study in Scarlet by Arthur Conan Doyle
    Notes from the Underground by Fyodor Dostoyevsky
    Meditations by Emperor of Rome Marcus Aurelius
    The Prophet by Kahlil Gibran
    The Republic by Plato
    Second Treatise of Government by John Locke
    Emma by Jane Austen
    Frankenstein; Or, The Modern Prometheus by Mary Wollstonecraft Shelley
    Oliver Twist by Charles Dickens
    Antiquities of the Jews by Flavius Josephus
    Narrative of the Life of Frederick Douglass, an American Slave by Frederick Douglass
    The Satires of Juvenal, Persius, Sulpicia, and Lucilius by Juvenal
    The First Book of Adam and Eve by Rutherford Hayes Platt
    Persuasion by Jane Austen
    Gulliver's Travels into Several Remote Nations of the World by Jonathan Swift
    Pygmalion by Bernard Shaw
    Anthem by Ayn Rand
    The Time Machine by H. G. Wells
    Paradise Lost by John Milton
    The Social Cancer: A Complete English Version of Noli Me Tangere by José Rizal
    The King in Yellow by Robert W. Chambers
    White Nights and Other Stories by Fyodor Dostoyevsky
    The Rámáyan of Válmíki, translated into English verse by Valmiki
    The King James Version of the Bible
    Josefine Mutzenbacher by Felix Salten
    The Confessions of St. Augustine by Bishop of Hippo Saint Augustine
    """.split(separator: "\n").map{ "\($0)" }


let animesList =
"""
.злам// Поза «World'-ом»↑.hack//The Movie セカイの向こうに|.hack//The Movie: Sekai no Mukou ni|hack//Beyond the World
10 Сміливців↑ブレイブ・テン|Brave 10|Brave10|Brave Ten
16-ти бітне Сприйняття Інший Рівень↑16bitセンセーション ANOTHER LAYER|16bit Sensation: Another Layer
35-й тестовий шкільний антимагічний загін↑対魔導学園35試験小隊|Anti-Magic Academy: The 35th Test Platoon|Taimadou Gakuen Sanjuugo Shiken Shoutai
3х3 Ока: Безсмертні↑3×3EYES|3x3 Eyes|Sazan Eyes|3x3 Eyes: Immortals
3х3 Ока: Легенда про Божественного Демона↑3×3 EYES聖魔伝説|3x3 Eyes: Legend of the Divine Demon|Shin 3x3 Eyes|Sazan Eyes: Seima Densetsu
5 сантиметрів за секунду↑秒速５センチメートル|5 Centimeters per Second|Five Centimeters Per Second|Byousoku 5 Centimeter - a chain of short stories about their distance|5 Centimetres Per Second|5 cm per second
7 насінин↑7SEEDS|7 Seeds|Seven Seeds
9 історій про кохання↑愛物語 9 Love Stories|Ai Monogatari: 9 Love Stories|Kawaguchi Kaiji's 9 Love Stories
91 день↑91Days|91 Days
A.I.C.O. Втілення↑A.I.C.O. -Incarnation-|A.I.C.O. Incarnation|AICO
B: Початок↑B: The Beginning
B: початок. Спадщина↑B: The Beginning Succession|B: The Beginning 2nd Season
C - Валюта душі та контроль імовірностей↑「C」 THE MONEY OF SOUL AND POSSIBILITY CONTROL|[C] CONTROL - The Money and Soul of Possibility|[C] The Money of Soul and Possibility Control
Cиній екзорцист: Арка Ілюмінатів Шімане↑青の祓魔師 島根啓明結社篇|Blue Exorcist: Shimane Illuminati Saga|Ao no Futsumashi
Cхідний Едем: Король Едему↑東のエデン 劇場版I The King of Eden|Eden of The East the Movie I: The King of Eden|Higashi no Eden: Gekijouban I The King of Eden
H2O: Сліди на піску↑H2O ~FOOTPRINTS IN THE SAND~|H2O: Footprints in the Sand
ID: Вторгнення↑ID:INVADED イド:インヴェイデッド|ID: INVADED
IS: Неосяжні небеса на біс – Палкий Секстет ОВА↑IS 〈インフィニット・ストラトス〉 アンコール『恋に焦がれる六重奏』|IS: Infinite Stratos Encore - Koi ni Kogareru Rokujuusou|IS: Infinite Stratos Encore - Koi ni Kogareru Sextet
MF Ghost↑MFゴースト|MF Ghost
Mass Effect: Згуба Параґону↑マスエフェクト～失われたパラゴン|Mass Effect: Paragon Lost|Mass Effect Animation|Mass Effect: Ushinawareta Paragon
Mass Effect: Згуба Параґону↑マスエフェクト～失われたパラゴン|Mass Effect: Paragon Lost|Mass Effect Animation|Mass Effect: Ushinawareta Paragon
Mass Effect: Згуба Параґону↑マスエフェクト～失われたパラゴン|Mass Effect: Paragon Lost|Mass Effect Animation|Mass Effect: Ushinawareta Paragon
SSSS. Ґрідмен↑SSSS.GRIDMAN|SSSS.Gridman
WIXOSS: Селектор-поширювач↑selector spread WIXOSS
Wixoss: Заражений селектор↑selector infected WIXOSS
X TV (Ікс)↑X−エックス−|X|X the TV Series|X/1999|Ekksu|X (2001)
xxxГолік↑×××HOLiC（ホリック）|xxxHOLiC
xxxГолік – Весняний сон↑xxxHOLiC 春夢記|xxxHOLiC Shunmuki|xxxHOLiC OVA
xxxГолік – Сон літньої ночі↑劇場版　×××HOLiC　真夏ノ夜ノ夢|xxxHOLiC The Movie: A Midsummer Night's Dream|Gekijouban Horikku - Manatsu no Yoru no Yume|X-zobanHOLIC: Manatsu no Yo no Yume|xxxHolic - The Movie - A Midsummer's Night Dream
«Героїні» у відставці↑「英雄」解体|Eiyu Kaitai|"Heroes" Dismissed
«Героїні» у відставці↑「英雄」解体|Eiyu Kaitai|"Heroes" Dismissed|Eiyuu Kaitai
«Героїні» у відставці↑「英雄」解体|Eiyu Kaitai|"Heroes" Dismissed
Євангеліон - 1.0 Ти (Не) Самотній / Євангеліон по-новому↑ヱヴァンゲリヲン新劇場版:序|Evangelion: 1.0 You Are (Not) Alone|Evangelion Shin Gekijouban: Jo|Rebuild of Evangelion: 1.0 You Are (Not) Alone|Evangelion: 1.01 You Are (Not) Alone|Evangelion: 1.11 You Are (Not) Alone
Євангеліон 1.11 Ти (Не) Самотній↑ヱヴァンゲリヲン新劇場版:序|Evangelion: 1.0 You Are (Not) Alone|Evangelion Shin Gekijouban: Jo|Rebuild of Evangelion: 1.0 You Are (Not) Alone|Evangelion: 1.01 You Are (Not) Alone|Evangelion: 1.11 You Are (Not) Alone
Євангеліон 2.22: Ти (Не) Пройдеш↑ヱヴァンゲリヲン新劇場版:破|Evangelion: 2.0 You Can (Not) Advance|Evangelion Shin Gekijouban: Ha|Rebuild of Evangelion: 2.0 You Can (Not) Advance|Evangelion 2.22
Євангеліон 2.22: Ти (Не) Пройдеш↑ヱヴァンゲリヲン新劇場版:破|Evangelion: 2.0 You Can (Not) Advance|Evangelion Shin Gekijouban: Ha|Rebuild of Evangelion: 2.0 You Can (Not) Advance|Evangelion 2.22
Євангеліон 3.0 Ти (Не) Зміниш↑ヱヴァンゲリヲン新劇場版:Q|Evangelion: 3.0 You Can (Not) Redo|Evangelion Shin Gekijouban: Kyuu|Rebuild of Evangelion: 3.0|Evangelion: 3.0 Q Quickening|Evangelion 3.33
Євангеліон 3.0 Ти (Не) змiниш↑ヱヴァンゲリヲン新劇場版:Q|Evangelion: 3.0 You Can (Not) Redo|Evangelion Shin Gekijouban: Kyuu|Rebuild of Evangelion: 3.0|Evangelion: 3.0 Q Quickening|Evangelion 3.33
Євангеліон 3.0 Ти (Не) зміниш↑ヱヴァンゲリヲン新劇場版:Q|Evangelion: 3.0 You Can (Not) Redo|Evangelion Shin Gekijouban: Kyuu|Rebuild of Evangelion: 3.0|Evangelion: 3.0 Q Quickening|Evangelion 3.33
Євангеліон 3.0+1.0 Одного разу↑シン・エヴァンゲリオン劇場版:|||Evangelion: 3.0+1.0 Thrice Upon a Time|Evangelion: 4.0|Rebuild of Evangelion|Shin Evangelion Gekijouban: |||Rebuild of Evangelion: Final
Єднання Сердець↑ココロコネクト|Kokoro Connect|Kokoroco
Ігрища розуму↑マインド・ゲーム|Mind Game|Mindgame
Ідіотка↑アホガール|AHO-GIRL|Ahogaru: Clueless Girl|Dummy Girl
Іксіон: Сказання про НЗ↑イクシオン サーガ DT|Ixion Saga DT|Ixion Saga: Dimensional Transfer
Інтерлюдія ОВА↑インタールード|Interlude
Інтерстелла 5555↑インターステラ5555|Interstellar 5555
Іну-О↑犬王|Inu-Oh
Інукамі!↑いぬかみっ!|Inukami!|Dog Gods!
Інуяша↑犬夜叉|InuYasha|Inu Yasha
Інуяша. Фільм 1 - Кохання, яке здолало час↑犬夜叉 時代を越える想い|InuYasha the Movie: Affections Touching Across Time|Inu Yasha: Toki wo Koeru Omoi|InuYasha: Love That Transcends Time
Інуяша. Фільм 2 - Палац із задзеркалля↑犬夜叉 鏡の中の夢幻城|InuYasha the Movie 2: The Castle Beyond the Looking Glass|Inu Yasha: Kagami no Naka no Mugenjou
Інуґамі-сан та Некояма-сан↑犬神さんと猫山さん|Inugami-san to Nekoyama-san
Інфініті Надо (5 сезон)↑战斗王之飓风战魂5|Zhandou Wang Zhi Jufeng Zhan Hun 5|King of Warrior 5|Infinity Nado 5
Інша↑アナザー|Another
Інша країна↑二ノ国|Ni no Kuni|NiNoKuni
Інша країна↑二ノ国|Ni no Kuni|NiNoKuni
Інша країна↑二ノ国|Ni no Kuni|NiNoKuni
Інший світ↑別世界|Betsu Sekai|Bessekai|Another World
Ініціал Д: Додатковий етап↑頭文字〈イニシャル〉D EXTRA STAGE|Initial D Extra Stage
Ініціал Д: Другий етап↑頭文字〈イニシャル〉D SECOND STAGE|Initial D Second Stage
Ініціал Д: Змагальний етап↑頭文字〈イニシャル〉D BATTLE STAGE|Initial D Battle Stage
Ініціал Д: Перший етап↑頭文字〈イニシャル〉D|Initial D First Stage|ID
Ініціал Д: Третій етап↑頭文字〈イニシャル〉D THIRD STAGE|Initial D Third Stage
Ініціал Д: Четвертий етап↑頭文字〈イニシャル〉D FOURTH STAGE|Initial D 4th Stage
Інґрес↑INGRESS THE ANIMATION|Ingress the Animation
Іржоїд Біско / Пожирач іржі Біско↑錆喰いビスコ|Sabikui Bisco|Rust-Eater Bisco
Ірія↑イ・リ・ア ゼイラム The Animation|Iria: Zeiram The Animation
Історія Марі↑마리이야기|Mari Iyagi|My Beautiful Girl Mari
Історія квітів↑花物語|Hanamonogatari|Monogatari Series: Second Season +α
Історія кохання Тамако↑たまこラブストーリー|Tamako Love Story|Tamako Market Movie
Історія кохання Тамако↑たまこラブストーリー|Tamako Love Story|Tamako Market Movie
Історія кохання Тамако↑たまこラブストーリー|Tamako Love Story|Tamako Market Movie
Історія мого кохання!!↑俺物語!!|My Love Story!!|Ore Monogatari!!|My Story!!
Історія одержимості↑憑物語|Tsukimonogatari|Tsukimonogatari: Yotsugi Doll|Monogatari Final Season
Історії Койомі↑暦物語|Koyomimonogatari|Calendar Story
Історії мечів↑刀語|Katanagatari|Sword Story
Історії монстрів↑化物語|Bakemonogatari|Ghostory|Monstory
Історії монстрів (Сезон 2)↑〈物語〉シリーズ セカンドシーズン|Monogatari Series: Second Season|Nekomonogatari: Shiro|Kabukimonogatari|Otorimonogatari|Onimonogatari|Koimonogatari
Історії підробок↑偽物語|Nisemonogatari|Impostory
Ішура↑異修羅|Ishura
Їх було одинадцять↑11人いる!|They Were Eleven|They Were 11|Juuichinin Iru!
А ти думав, що твоя дружина в грі насправді не дівчина?↑ネトゲの嫁は女の子じゃないと思った？|And you thought there is never a girl online?|Net Game no Yome wa Onna no Ko ja Nai to Omotta?|NetoYome
Аватар Короля↑全职高手|The King's Avatar|Quan Zhi Gao Shou|Full-Time Expert|Expert of All Classes
Агенство небезпечних послуг "Мецо"↑メゾ|Mezzo DSA|Mezzo Danger Service Agency|Mezzo Forte TV|Mezzo TV Danger Service Agency
Агент параної↑妄想代理人|Paranoia Agent|Mousou Dairinin
Агов, Курча!↑まよチキ!|Mayo Chiki!
Агов, у тебе вушка видно!↑喂，看見耳朵啦！|Wei, Kanjian Erduo La!|Hora|Mimi ga Mieteru yo!|Hey|Your Ears Are Showing!
Агресивна Рецуко↑アグレッシブ烈子|Aggretsuko
Агресивна Рецуко (Сезон 3)↑アグレッシブ烈子第3期|Aggretsuko (ONA) 3rd Season|Aggretsuko 3rd Season
Агресивна Рецуко (сезон 2)↑アグレッシブ烈子第2期|Aggretsuko (ONA) 2nd Season|Aggretsuko 2nd Season
Адачі та Шімамура↑安達としまむら|Adachi and Shimamura|Adashima
Аджіму - пляжна історія↑あじむ ～海岸物語～|Ajimu: Kaigan Monogatari|Ajimu: Beach Story
Адзуманґа Дайо↑あずまんが大王 THE ANIMATION|Azumanga Daioh: The Animation|Azumanga Daiou
Азуманґа Дайо: Дуже Короткий Фільм↑あずまんが大王（劇場短編）|Azumanga Daioh: The Very Short Movie|Azumanga Daiou: The Very Short Movie
Азуманґа Дайо: Дуже Короткий Фільм↑あずまんが大王（劇場短編）|Azumanga Daioh: The Very Short Movie|Azumanga Daiou: The Very Short Movie
Айра↑あいうら|Aiura
Айшілд 21↑アイシールド21|Eyeshield 21|Eyeshield21
Академія Юних Відьом↑リトルウィッチアカデミア|Little Witch Academia|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|LWA
Академія Юних Відьом↑リトルウィッチアカデミア|Little Witch Academia|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|LWA
Академія Юних Відьом↑リトルウィッチアカデミア|Little Witch Academia|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|LWA
Академія Юних Відьом↑リトルウィッチアカデミア|Little Witch Academia|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|LWA
Академія Юних Відьом↑リトルウィッチアカデミア|Little Witch Academia|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|LWA
Академія Юних Відьом: Зачарований Парад↑リトルウィッチアカデミア 魔法仕掛けのパレード|Little Witch Academia: The Enchanted Parade|LWA 2|Little Witch Academia 2
Академія Юних Відьом: Зачарований Парад↑リトルウィッチアカデミア 魔法仕掛けのパレード|Little Witch Academia: The Enchanted Parade|LWA 2|Little Witch Academia 2|Little Witch Academia: The Enchanted Parade / Little Witch Academia: Mahoujikake no Parade
Академія Юних Відьом: Зачарований Парад↑リトルウィッチアカデミア 魔法仕掛けのパレード|Little Witch Academia: The Enchanted Parade|LWA 2|Little Witch Academia 2
Актори міста Мекаку↑メカクシティアクターズ|MEKAKUCITY ACTORS|Mekaku City Actors|Kagerou Project
Акторка Тисячоліття↑千年女優|Millennium Actress|Chiyoko Millennial Actress
Акторка Тисячоліття↑千年女優|Millennium Actress|Chiyoko Millennial Actress
Акудама драйв↑アクダマドライブ|Akudama Drive
Акіра↑AKIRA（アキラ）|Akira
Акіра↑AKIRA（アキラ）|Akira
Алдноа.Зеро↑アルドノア・ゼロ（第2クール）|Aldnoah.Zero|Aldnoah.Zero 2nd Season
Алель Кідзуне↑絆のアリル|Kizuna no Allele
Алель Кідзуне (2 сезон)↑絆のアリル|Kizuna no Allele Season 2|Kizuna no Allele 2nd Season
Альтернативний Сворд Арт Онлайн: Ґан Ґейл Онлайн↑ソードアート・オンライン オルタナティブ ガンゲイル・オンライン|Sword Art Online Alternative: Gun Gale Online|SAO Alternative Gun Gale Online
Аліса й Зороку↑アリスと蔵六|Alice & Zoroku
Аманчю (сезон 2)↑あまんちゅ！～あどばんす～|Amanchu! Advance|Amanchu! 2
Аманчю!↑あまんちゅ！|Amanchu!
Амон: Апокаліпсис Людини-Диявола↑AMON デビルマン黙示録|Amon: Apocalypse of Devilman|Amon: The Apocalypse of Devilman
Амон: Апокаліпсис Людини-Диявола↑AMON デビルマン黙示録|Amon: Apocalypse of Devilman|Amon: The Apocalypse of Devilman
Анна із зелених дахів↑赤毛のアン グリーンゲーブルズへの道|Akage no Anne: Green Gables e no Michi|Anne of Green Gables: Road to Green Gables
Анна із зелених дахів↑赤毛のアン グリーンゲーブルズへの道|Akage no Anne: Green Gables e no Michi|Anne of Green Gables: Road to Green Gables
Анна із зелених дахів↑赤毛のアン グリーンゲーブルズへの道|Akage no Anne: Green Gables e no Michi|Anne of Green Gables: Road to Green Gables
Анна із зелених дахів↑赤毛のアン|Anne of Green Gables|Sekai Meisaku Gekijou, Red haired Anne, Anne the Redhead
Аніме-тренування!↑あにトレ！ＥＸ|Anime de Training! Ex|Ani Tore! EX
Аніме-тренування! ТБ - 2↑あにトレ! XX~ひとつ屋根の下で~|Anime de Training! Xx|Ani Tore! XX
Аой Ашіто / Ао Аші. Шлях Аоя Ашіто↑アオアシ|Aoashi
Аполлон зі схилу↑坂道のアポロン|Kids on the Slope|Sakamichi no Aporon|Apollo on the Slope
Аппаре Рамман↑天晴爛漫！|Appare-Ranman!|Appare Ranman!
Ар-тонеліко↑アルトネリコ 世界の終わりで詩い続ける少女|Ar Tonelico: Sekai no Owari de Utai Tsuzukeru Shoujo|Ar Tonelico: The Girl Who Sings at the End of the World
Арв Резл: Механічні феї↑アルヴ・レズル -機械仕掛けの妖精たち-|Arve Rezzle: Kikaijikake no Yousei-tachi|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|Aruvu Rezuru|Aruvu Rezuru: Kikai Jikake no Yousei-tachi|Aruvu Rezuru: Mechanized Fairies|Arve Rezzle: Mechanized Fairies|Arve Rezzle: Kikaijikake no Yoseitachi
Арв Резл: Механічні феї↑アルヴ・レズル -機械仕掛けの妖精たち-|Arve Rezzle: Kikaijikake no Yousei-tachi|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|Aruvu Rezuru|Aruvu Rezuru: Kikai Jikake no Yousei-tachi|Aruvu Rezuru: Mechanized Fairies|Arve Rezzle: Mechanized Fairies|Arve Rezzle: Kikaijikake no Yoseitachi
Арв Резл: Механічні феї↑アルヴ・レズル -機械仕掛けの妖精たち-|Arve Rezzle: Kikaijikake no Yousei-tachi|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012|Aruvu Rezuru|Aruvu Rezuru: Kikai Jikake no Yousei-tachi|Aruvu Rezuru: Mechanized Fairies|Arve Rezzle: Mechanized Fairies|Arve Rezzle: Kikaijikake no Yoseitachi
Аркнайт: Повернення в крижану в'язницю↑アークナイツ【冬隠帰路/PERISH IN FROST】|Arknights: Perish in Frost|Arknights: Fuyukomori Kaerimichi
Армітаж III↑アミテージ・ザ・サード|Armitage III
Армітаж: Подвійна Матриця↑アミテージ・ザ・サード DUAL-MATRIX|Armitage III: Dual-Matrix|Armitage: Dual-Matrix|Amiteeji the Third Gekijouban|Armitage III: Dual Matrix
Арпеджіо блакитної сталі↑蒼き鋼のアルペジオ ‐アルス・ノヴァ‐|Arpeggio of Blue Steel -Ars Nova-|Aoki Hagane no Arpeggio: Ars Nova
Арпеджіо блакитної сталі -Арс Нова- DC↑劇場版 蒼き鋼のアルペジオ -アルス・ノヴァ- DC|Aoki Hagane no Arpeggio: Ars Nova Movie 1 - DC|Aoki Hagane no Arpeggio: Ars Nova DC|Arpeggio of Blue Steel: Ars Nova Movie 1|Gekijouban Aoki Hagane no Arpeggio
Арте↑アルテ|Arte
Артісвіч↑Artiswitch（アーティスウィッチ）|Artiswitch
Арія↑ARIA The ANIMATION|Aria the Animation
Асасінс Прайд↑アサシンズプライド|Assassins Pride
Астрономічний записник↑アストロノオト|Astro Note
Атака титанів: Фінальний сезон (сезон 4, частина 2)↑進撃の巨人 The Final Season Part 2|Attack on Titan: Final Season Part 2|Shingeki no Kyojin Season 4, Attack on Titan Season 4
Атака титанів: Фінальний сезон (сезон 4, частина 3-4)↑進撃の巨人 The Final Season完結編|Attack on Titan: Final Season - The Final Chapters|Shingeki no Kyojin: The Final Season Part 3|Shingeki no Kyojin Season 4|Attack on Titan Season 4
Ательє часу / Агенти часу↑时光代理人|Link Click|時光代理人|Jikou Dairinin|Shi Guang Dai Li Ren
Аура: остання битва Ікла Світла, демона-обранця драконів↑AURA～魔竜院光牙最後の闘い～|Aura: Koga Maryuin's Last War|Aura: Maryuinkoga Saigo no Tatakai|Aura: Maryuin Kouga Saigo no Tatakai
Афросамурай↑アフロサムライ|Afro Samurai
Афросамурай↑アフロサムライ|Afro Samurai
Ачі та Шіпак↑아치와 씨팍|Aachi and Ssipak|Aachi & Ssipak
Ашюра↑アシュラ|Asura|Ashura
Ашюра↑アシュラ|Asura|Ashura
Ашюра↑アシュラ|Asura|Ashura
Ая та відьма↑アーヤと魔女|Earwig and the Witch
Ая та відьма↑アーヤと魔女|Earwig and the Witch|Earwig and the Witch / Aya to majo
БЕМ↑BEM|Bem
Бакуган: Бойова планета↑爆丸バトルプラネット|Bakugan: Battle Planet
Бакуман↑バクマン。|Bakuman|Bakuman Season 1
Бакі Ханма син велетня↑範馬刃牙 SON OF OGRE|Baki Hanma|The Boy Fascinating the Fighting God
Бананько↑ばなにゃ|Bananya
Бармен↑バーテンダー|Bartender
Бармен: Божественний келих↑バーテンダー 神のグラス|Bartender: Glass of God
Баскетбол Куроко (1 сезон)↑黒子のバスケ|Kuroko's Basketball|Kuroko no Basuke|KuroBas|The Basketball Which Kuroko Plays
Баскетбол Куроко 2↑黒子のバスケ|Kuroko's Basketball 2|Kuroko no Basuke 2nd Season|The Basketball Which Kuroko Plays
Баунті Доґ↑バウンティドッグ~月面のイブ~|Bounty Dog: Getsumen no Eve
Без гри нема життя↑ノーゲーム・ノーライフ|No Game, No Life|NGNL
Без гри нема життя: Зеро↑ノーゲーム・ノーライフ ゼロ|No Game, No Life: Zero|NGNL Zero|NGNL the Movie|No Game No Life: Zero
Без гри нема життя: Зеро↑ノーゲーム・ノーライフ ゼロ|No Game, No Life: Zero|NGNL Zero|NGNL the Movie
Безсмертна література↑青い文学シリーズ|Aoi Bungaku Series|Blue Literature
Безтурботна старшокласниця↑女子かう生|Joshi Kausei|Jyoshi Kausei
Безтурботні часи↑のんのんびより|Non Non Biyori
Безтурботні часи: На біс↑のんのんびより りぴーと|Non Non Biyori Repeat|Non Non Biyori 2nd Season|Non Non Biyori Second Season
Безтурботні часи: На біс↑のんのんびより りぴーと|Non Non Biyori Repeat|Non Non Biyori 2nd Season|Non Non Biyori Second Season
Безтурботні часи: Нонстоп↑のんのんびより のんすとっぷ|Non Non Biyori Nonstop|Non Non Biyori 3rd Season|Non Non Biyori Third Season
Безхатній Бог - Нораґамі: Араґото↑ノラガミ ARAGOTO|Noragami Aragoto
Безхатній Бог - нораґамі↑ノラガミ|Noragami
Безхатній Бог - нораґамі ОВА↑ノラガミ OAD|Noragami OVA|Noragami OAD
Безіменна пам'ять / Безіменний спогад↑Unnamed Memory
Бейблейд X↑ベイブレードエックス|Beyblade X
Бейонетта: Кривава доля↑ベヨネッタ ブラッディフェイト|Bayonetta: Bloody Fate|BAYONETTA BLOODYFATE
Бек: східний ударний гурт↑ベック|Beck: Mongolian Chop Squad|BECK
Беладона смутку↑哀しみのベラドンナ|Belladonna of Sadness|Tragedy of Belladonna
Беладона смутку↑哀しみのベラドンナ|Belladonna of Sadness|Tragedy of Belladonna
Березневий лев↑3月のライオン|March Comes In Like a Lion|Sangatsu no Lion
Берсерк (ТБ-2)↑ベルセルク|Berserk (2016)
Берсерк - Золота Ера: Частина третя - Занепад↑ベルセルク 黄金時代篇Ⅲ 降臨|Berserk: The Golden Age Arc III - The Advent|Berserk Movie|Berserk Saga|Berserk: Golden Age Arc III - Descent
Берсерк: Золота Ера - Яйце Верховного Повелителя↑ベルセルク 黄金時代篇Ⅰ 覇王の卵|Berserk: The Golden Age Arc I - The Egg of the King|Berserk Movie|Berserk Saga|Berserk: Golden Age Arc I - Egg of the Supreme Ruler|The Golden Age Arc I: The High King's Egg
Берсерк: Пам'ятне Видання↑ベルセルク 黄金時代篇　MEMORIAL EDITION|Berserk: The Golden Age Arc - Memorial Edition
Бетмен-ніндзя↑ニンジャバットマン|Batman Ninja
Бетмен-ніндзя↑ニンジャバットマン|Batman Ninja
Блакитна раса↑BLUE GENDER|Blue Gender
Блакитна риба-метелик↑B.B. フィッシュ|B.B. Fish|Blue Butterfly Fish
Блакитна №6↑青の6号|Blue Submarine No. 6|Ao no 6-go|Ao no Rokugou|Ao no Rokugo
Блакитний Архів↑ブルーアーカイブ The Animation|Blue Archive the Animation
Блакитний Екзорцист: Фільм↑劇場版 青の祓魔師（エクソシスト）|Blue Exorcist: The Movie|Ao no Exorcist Gekijouban|Ao no Futsumashi Movie|Blue Exorcist Movie
Блакитний гігант↑BLUE GIANT
Блакитний гігант↑BLUE GIANT|Blue Giant
Блакитний гігант↑BLUE GIANT
Блам!↑BLAME (ブラム!)|Blame!
Блам!↑BLAME!|Blame!: The Movie|Blame!: The Ancient Terminal City|Blame!: Tanmatsu Ikou Toshi
Блам!↑BLAME!|Blame!: The Movie|Blame!: The Ancient Terminal City|Blame!: Tanmatsu Ikou Toshi|Blame! Movie
Блам!↑BLAME!|Blame!: The Movie|Blame!: The Ancient Terminal City|Blame!: Tanmatsu Ikou Toshi
Блек Джек↑ブラック・ジャック|Black Jack|Black Jack OVA|Black Jack Final
Блек Джек 21↑ブラック・ジャック21|Black Jack 21|BJ21
Блискотіння↑たまゆら|Tamayura
Блукач Кеншін: Романтичне сказання про мечника епохи Мейджі↑るろうに剣心 -明治剣客浪漫譚-|Rurouni Kenshin: Meiji Kenkaku Romantan (2023)
Блюз машини часу про чотири з половиною татамі↑四畳半タイムマシンブルース|The Tatami Time Machine Blues
Блідий кокон↑ペイル・コクーン|Pale Cocoon|Aoi Tamago
Блідий кокон↑ペイル・コクーン|Pale Cocoon|Aoi Tamago
Блідий кокон↑ペイル・コクーン|Pale Cocoon|Aoi Tamago
Бліч↑BLEACH - ブリーチ -|Bleach
Бліч 2: Повстання алмазного пилу. Інший Хьорінмару↑劇場版 BLEACH The DiamondDust Rebellion もう一つの氷輪丸|Bleach the Movie: The DiamondDust Rebellion
Бліч: Зникаючи в пітьмі, я кличу тебе↑劇場版 BLEACH Fade to Black 君の名を呼ぶ|Bleach the Movie: Fade to Black|Fade to Black: Call Out Your Name
Бліч: Повстання алмазного пилу. Інший Хьорінмару↑劇場版 BLEACH The DiamondDust Rebellion もう一つの氷輪丸|Bleach the Movie: The DiamondDust Rebellion
Бліч: Спогади в забутті↑劇場版 BLEACH MEMORIES OF NOBODY|Bleach the Movie: Memories of Nobody
Бліч: Спогади в забутті↑劇場版 BLEACH MEMORIES OF NOBODY|Bleach the Movie: Memories of Nobody
Бог старшої школи↑THE GOD OF HIGH SCHOOL ゴッド・オブ・ハイスクール|The God of High School|Gat Obeu Hai Seukul|갓 오브 하이스쿨|GOHS
Богиня жадає ігор↑神は遊戯に飢えている。|Gods' Game We Play|Kami wa Yuugi ni Ueteiru.|The Ultimate Game-Battles of a Boy and the Gods|Kami wa Game ni Ueteiru.: Kamigami ni Idomu Shounen no Kyuukyoku Zunousen
Божественна брама↑ディバインゲート|Divine Gate|ディバゲ
Божественна сімейка↑神様家族|Kamisama Kazoku|Kami-sama Kazoku
Божественний коваль↑聖剣の刀鍛冶（ブラックスミス）|The Sacred Blacksmith|Seiken no Katanakaji
Бойова Шінкі: Місячний Янгол↑武装神姫 Moon Angel|Busou Shinki Moon Angel
Бойовий Континент / Країна Душ↑斗罗大陆|Douluo Dalu|Combat Continent|Soul Land
Бойовий поцілунок↑Engage Kiss
Бородате курча|Хігепіо|Бородате курча / Хігепіо↑ひげぴよ, ヒゲぴよ|Higepiyo|Hige Piyo
Боруто: День, коли Наруто став Хокаґе↑BORUTO -NARUTO THE MOVIE- ナルトが火影になった日|Boruto: Naruto the Movie - The Day Naruto Became Hokage|The Day Naruto Became Hokage
Боруто: Наруто фільм↑BORUTO -NARUTO THE MOVIE-|Boruto: Naruto the Movie|Gekijouban Naruto (2015)
Боруто: Наруто – Фільм↑BORUTO -NARUTO THE MOVIE-|Boruto: Naruto the Movie|Gekijouban Naruto (2015)
Боруто: Нове покоління Наруто↑BORUTO -NARUTO NEXT GENERATIONS-|Boruto: Naruto Next Generations
Боязкий велосипедист↑弱虫ペダル|Yowamushi Pedal|Yowapeda
Боєць Бакі↑バキ|Baki
Боєць Бакі (ОВА)↑グラップラー刃牙|Grappler Baki|Grappler Baki: The Ultimate Fighter|Baki the Grappler: The Ultimate Fighter
Боєць Бакі: Найвеличніший турнір↑グラップラー刃牙(バキ) 最大トーナメント編|Baki the Grappler: Saidai Tournament-hen|Baki the Grappler II|Grappler Baki Second Season|Baki The Grappler - The Ultimate Tournament|Grappler Baki Maximum Tournament
Брама: Самооборона в зоні конфлікту (2 сезон)↑GATE（ゲート）自衛隊　彼の地にて、斯く戦えり　第2クール|GATE Part 2|Gate: Jieitai Kanochi nite|Kaku Tatakaeri 2nd Season|Gate: Thus the JSDF Fought There! Fire Dragon Arc|Kaku Tatakaeri - Enryuu-hen
Брама;Штейна / Штейнова Брама↑STEINS;GATE|Steins;Gate
Брама;Штейна Область Перезавантаження Дежавю↑劇場版 シュタインズゲート 負荷領域のデジャヴ|Steins;Gate: The Movie - Load Region of Déjà Vu|Steins Gate Movie
Брама;Штейна Область Перезавантаження Дежавю↑劇場版 シュタインズゲート 負荷領域のデジャヴ|Steins;Gate: The Movie - Load Region of Déjà Vu|Steins Gate Movie
Братерство Чорної крові↑ブラック・ブラッド・ブラザーズ|Black Blood Brothers
Братерство: Остання фантазія XV↑BROTHERHOOD FINAL FANTASY XV|Brotherhood: Final Fantasy XV
Брехун Брехун↑ライアー・ライアー|Liar Liar
Бруд до бруду↑ドロヘドロ|Dorohedoro
Брухтенбург↑スウェットパンチ|Sweat Punch|Deep Imagination|Dan Petory Kyoushu no Yuutsu|Professor Dan Petry's Blues|End of the World|Kigeki|Comedy|Higan|Beyond|Garakuta no Machi|Junk Town
Брюнгільда з пітьми↑極黒のブリュンヒルデ|Brynhildr in the Darkness|Gokukoku no Brynhildr
Бтум!↑BTOOOM!
Буденне життя Суно та Ману↑おかしなさばくのスナとマヌ|Okashi na Sabaku no Suna to Manu
Будні на узбережжі↑放課後ていぼう日誌|Diary of Our Days at the Breakwater|Hokago Teibo Nisshi|Afterschool Embankment Journal
Булбастер↑ブルバスター|Bullbuster
Бульбашка↑バブル|Bubble
Бульбашка↑バブル|Bubble
Буремне життя карательки↑処刑少女の生きる道〈バージンロード〉|The Executioner and Her Way of Life|Shokei Shoujo no Ikiru Michi
Буря Втрат: Знищення Цивілізації↑絶園のテンペスト|Blast of Tempest|Zetsuen no Tempest: The Civilization Blaster
Бута↑BUTA|Buta|Wakate Animator Ikusei Project|2011 Young Animator Training Project|Anime Mirai 2011
Бути героєм↑TO BE HERO|To Be Hero|Tu Bian Ying Xiong Baba|凸变英雄 BABA
Бучіґірі?!↑ぶっちぎり?!|Bucchigiri?!
Буші Роуд↑熱風海陸ブシロード|Neppuu Kairiku Bushi Road|Burning Wind Ocean Earth Samurai Lord|Bushilord|Bushiroad|Neppu Kairiku Bushi Road
Біла Коробка↑SHIROBAKO|Shirobako|White Box
Біла Коробка Спецвипуск↑SHIROBAKO 劇中劇アニメーション|Shirobako Specials
Біла Коробка: Кіно↑劇場版 SHIROBAKO|Shirobako Movie|White Box Movie
Біла ніч↑白夜玲珑|Whited Nighttime|Baiye Linglong
Білий альбом 2↑ホワイトアルバム2|White Album 2|White Album2|WA2
Білий хрест: Полум'я↑ヴァイスクロイツ・グリーエン|Knight Hunters Eternity|Weiss Kreuz Gluehen|Weiss Kreuz Gluhen|White Cross Glowing
Біомисливець↑バイオ・ハンター|Bio Hunter|Biohunter
Біомисливець↑バイオ・ハンター|Bio Hunter|Biohunter
ВАН ПІС: РЕД|Ван-Пiс: Червоний↑ONE PIECE FILM RED|One Piece Film: Red|One Piece Movie 15
ВАН ПІС: РЕД|Ван-Пiс: Червоний|ВАН ПІС: РЕД / Ван-Пiс: Червоний↑ONE PIECE FILM RED|One Piece Film: Red|One Piece Movie 15|One Piece Film Red
Вавилон↑バビロン|Babylon
Важкий об'єкт↑ヘヴィーオブジェクト|Heavy Object
Вайолет Евергарден: Спогади↑ヴァイオレット・エヴァーガーデン特別総集版|Violet Evergarden: Recollections|Violet Evergarden: Pour Mémoire
Ван Піс / Великий куш↑ONE PIECE|One Piece: The Movie
Ван Піс. Історія про золотого пірата Унана / Великий куш. Фільм 1↑ONE PIECE|One Piece: The Movie
Ван Піс. Історія про золотого пірата Унана. Фільм 1↑ONE PIECE|One Piece: The Movie|One Piece: The Movie
Ван Піс. Історія про золотого пірата Унана. Фільм 1↑ONE PIECE|One Piece: The Movie
Ван Піс: Рудий↑ONE PIECE FILM RED|One Piece Film: Red|One Piece Movie 15
Ван Піс: Фільм 10 - Сильний Світ↑ワンピース　フィルム　ストロングワールド|One Piece Film: Strong World|One Piece Movie 10
Ван Піс: Фільм 10 - Сильний Світ↑ワンピース　フィルム　ストロングワールド|One Piece Film: Strong World|One Piece Movie 10
Ван Піс: Фільм 10 - Сильний Світ↑ワンピース　フィルム　ストロングワールド|One Piece Film: Strong World|One Piece Movie 10|One Piece: Strong World
Ван Піс: Фільм 14 - Панічна Втеча↑劇場版『ONE PIECE STAMPEDE』（スタンピード）|One Piece: Stampede
Ван Піс: Фільм 14 - Панічна Втеча↑劇場版『ONE PIECE STAMPEDE』（スタンピード）|One Piece: Stampede
Ван Піс: Фільм 2 - Пригоди на острові Клокворк↑ワンピース ねじまき島の冒険|One Piece: Clockwork Island Adventure|One Piece: Nejimakijima no Bouken|One Piece: Nejimaki Shima no Bouken
Ван Піс: Фільм 9 - Історія Чоппера: Дивовижна квітуча сакура, що цвіте взимку↑ＯＮＥ ＰＩＥＣＥ（ワンピース） エピソードオブチョッパー＋冬に咲く、奇跡の桜|One Piece: Episode of Chopper Plus - Bloom in the Winter, Miracle Sakura
Ван Піс: Фільм 9 - Історія Чоппера: Дивовижна квітуча сакура, що цвіте взимку↑ＯＮＥ ＰＩＥＣＥ（ワンピース） エピソードオブチョッパー＋冬に咲く、奇跡の桜|One Piece: Episode of Chopper Plus - Bloom in the Winter, Miracle Sakura|One Piece: Episode of Chopper Plus: Bloom in the Winter, Miracle Cherry Blossom
Ван Піс: Фільм 9 - Історія Чоппера: Дивовижна квітуча сакура, що цвіте взимку↑ＯＮＥ ＰＩＥＣＥ（ワンピース） エピソードオブチョッパー＋冬に咲く、奇跡の桜|One Piece: Episode of Chopper Plus - Bloom in the Winter, Miracle Sakura
Ван піс фільм 13: Золото↑ONE PIECE FILM GOLD|One Piece Film: Gold|One Piece Movie 13
Ванпанчмен (1 сезон)↑ワンパンマン|One Punch Man|One Punch-Man|One-Punch Man|OPM
Ванґан Міднайт↑湾岸ミッドナイト|Wangan Midnight
Вас заарештовано!↑逮捕しちゃうぞ|You're Under Arrest|Taiho Shichauzo
Васалорд↑Vassalord. (ヴァッサロード)|Vassalord.
Вбивця гоблінів: Корона гоблінів↑ゴブリンスレイヤー -GOBLIN'S CROWN-|Goblin Slayer: Goblin's Crown
Вбивця гоблінів: Корона гоблінів↑ゴブリンスレイヤー -GOBLIN'S CROWN-|Goblin Slayer: Goblin's Crown
Вбивча принцеса↑マーダープリンセス|Murder Princess
Вбивчі укуси↑キリングバイツ|Killing Bites
Вбий мене, крихітко↑キルミーベイベー|Kill Me Baby|Baby|Please Kill Me
Ведмедики-кумедики↑くま クマ 熊 ベアー|Kuma Kuma Kuma Bear|The Bears Bear a Bare Kuma
Велика риба та яблуня↑大鱼海棠|Da Yu Hai Tang|Big Fish & Begonia
Велика різниця↑だんちがい|Danchigai
Великий О↑THEビッグオー|The Big O|Big O Roger|Big O
Великий шахрай: Разблюто↑GREAT PRETENDER razbliuto|Great Pretender: Razbliuto
Великий шахрай: Разблюто↑GREAT PRETENDER razbliuto|Great Pretender: Razbliuto
Вельзепуз↑べるぜバブ|Beelzebub
Венеріанські війни↑ヴィナス戦記|Venus Wars
Венеріанські війни↑ヴィナス戦記|Venus Wars
Вигнані з раю↑楽園追放 -Expelled from Paradise-|Expelled from Paradise
Видатні звірі (1 сезон)↑BEASTARS|Beastars
Видатні звірі (Сезон 2)↑BEASTARS 2期|Beastars 2nd Season
Видозмінений вуглець: Відновлений↑オルタード・カーボン: リスリーブド|Altered Carbon: Resleeved
Видозмінений вуглець: Відновлений↑オルタード・カーボン: リスリーブド|Altered Carbon: Resleeved
Викрадення кумира↑BE-BOY KIDNAPP'N IDOL|Be-Boy Kidnapp'n Idol|Be-Boy Kidnapping Idol
Вимір W↑Dimension W
Винищувач гоблінів (2 сезон) / Убивця Гоблінів (2 сезон)↑ゴブリンスレイヤーⅡ|Goblin Slayer II|Goblin Slayer 2nd Season
Винищувач танків Меллолінк↑機甲猟兵メロウリンク|Kikou Ryohei Mellowlink|Armor Hunter Mellowlink|Leechers Army Merowlink|Mellowlink
Високий удар Аяне!↑綾音ちゃんハイキック!|Ayane's High Kick
Високошвидкісна Етуаль↑HIGHSPEED Étoile（ハイスピードエトワール）|Highspeed Etoile
Височінь↑AIR|Air
Висхідне сонце↑Sol Levante
Витівки богів↑神々の悪戯|Kamigami no Asobi|Kamigami no Asobi: Ludere deorum|Kamiaso
Витівки під сакурою↑桜Trick|Sakura Trick
Вовча злива↑ウルフズレイン|Wolf's Rain|Wolf Rain
Вовчиця та Чорний Принц↑オオカミ少女と黒王子|Wolf Girl & Black Prince|Ookami Shoujo to Kuroouji
Вовчиця та прянощі: Купець зустрічає мудру вовчицю↑狼と香辛料 MERCHANT MEETS THE WISE WOLF|Spice and Wolf: Merchant Meets the Wise Wolf|Spice and Wolf
Вовчиця та спеції (1 cезон)↑狼と香辛料|Spice and Wolf|Ookami to Koushinryou
Волейбол (Сезон 2)↑ハイキュー!! セカンドシーズン|Haikyu!! 2nd Season|Haikyuu!! Second Season
Волейбол! (Сезон 1)↑ハイキュー!!|Haikyu!!|High Kyuu!!|HQ!!
Волейбол! (Сезон 3)↑ハイキュー!! 烏野高校 VS 白鳥沢学園高校|Haikyu!! 3rd Season|Haikyuu!! Third Season|Haikyuu!! Karasuno High VS Shiratorizawa Academy
Волейбол!!! До вершини (сезон 4, частина 1)↑ハイキュー!! TO THE TOP|Haikyu!! To the Top|Haikyuu!! (2020)|Haikyuu!! Fourth Season|Haikyuu!! 4th Season
Волейбол!!! До вершини (сезон 4, частина 2)↑ハイキュー TO THE TOP 第2クール|Haikyu!! To the Top 2nd-cour|Haikyu!! TO THE TOP 2nd-cour|Haikyu!! TO THE TOP Part 2
Володар демонів з гальорки↑いちばんうしろの大魔王|Demon King Daimao|Ichiban Ushiro no Dai Mao
Вольтрон: Оборонець всесвіту↑百獣王ゴライオン|Voltron: Defender of the Universe|Hyakujuu Ou Golion|Hundred-Beast King Go Lion|Lion Force Voltron|Voltran|Voltron (U.S.)
Вона та її кіт↑彼女と彼女の猫|She and Her Cat: Their Standing Points|Kanojo to Kanojo no Neko
Вона та її кіт↑彼女と彼女の猫|She and Her Cat: Their Standing Points|Kanojo to Kanojo no Neko
Вона – довершена зброя. Інша пісня кохання↑最終兵器彼女Another Love Song|Saikano: Another Love Song|Saishuuheiki Kanojo OVA|Saikano OVA
Ворона з глибин палацу↑後宮の烏|Raven of the Inner Palace|Kokyu no Karasu
Восьмий син? Та ви знущаєтеся!↑八男って、それはないでしょう！|The 8th son? Are you kidding me?|Hachinan tte|Sore wa Nai deshou!
Вперед! Акмен↑GO! GO! ACKMAN, ゴーゴーアックマン|Go! Go! Ackman
Врятуй мене, бойова феє Мейв!↑戦闘妖精少女 たすけて！メイヴちゃん|Sentou Yousei Shoujo Tasukete! Mave-chan|Sento Yosei Shojo Tasukete! Mave-chan|Battle Fairy Girl Help! Mave-chan|Fighting Fairy Girl Rescue Me Mave-chan
Все, що мені потрібно, це ти!↑一人しかいない自分|Hitori Shika Inai Jibun
Вторгнення Кальмарки 2↑侵略!?イカ娘|The Squid Girl 2|The Invader Comes From the Bottom of the Sea!|Shinryaku! Ika Musume 2
Втрата людяності↑HUMAN LOST 人間失格|Human Lost: Ningen Shikkaku|No Longer Human
Втілення богині: повість про цифрового диявола↑デジタル・デビル物語〈ストーリ〉 女神転生|Digital Devil Story: Megami Tensei|Digital Devil Monogatari Megami Tensei
Віві: Пісня флюоритового ока↑Vivy -Fluorite Eye's Song- (ヴィヴィ -フローライトアイズソング-)|Vivy -Fluorite Eye's Song-
Від епохи Ґенроку до Шьова: подвійне самогубство з ракуґо↑昭和元禄落語心中|Showa Genroku Rakugo Shinju|Showa and Genroku Era Lover's Suicide Through Rakugo
Відео Дівчинка Ай↑電影少女 VIDEO・GIRL・AI|Video Girl Ai|Den'ei Shoujo Video Girl AI
Відзавтра буде штиль↑凪のあすから|A Lull in the Sea|Nagi no Asukara|Nagiasu
Відображення зорепаду↑流れ星レンズ|Nagareboshi Lens|Shooting Star Lens|Ribon Festa 2012|Ribbon Festa 2012
Відтворювачі↑Re:CREATORS 〈レクリエイターズ〉|Re:CREATORS
Відчуй Вітер↑風が強く吹いている|Run with the Wind|Kaze ga Tsuyoku Fuite Iru|Kazetsuyo
Відьмин клинок↑ウィッチブレイド|Witchblade
Візуальна в'язниця↑ヴィジュアルプリズン|Visual Prison
Війна Майбутнього 198↑Future War 198X年|Future War Year 198X
Війна Майбутнього 198↑Future War 198X年|Future War Year 198X|Future War 198X
Війна Покоївок Акіби↑アキバ冥途戦争|Akiba Maid War|Akiba Maid Sensou
Війна майбутнього 198Х↑Future War 198X年|Future War Year 198X
Війни Сакури↑新サクラ大戦 the Animation|Sakura Wars the Animation|New Sakura Wars the Animation
Військо!↑みりたり!|Military!|Miritari!
Військова історія маленької дівчинки↑幼女戦記|Saga of Tanya the Evil|The Military Chronicles of a Little Girl
Вільний!↑Free!|Free! - Iwatobi Swim Club|フリー！
Вільний! Безкінечне Літо↑Free!-Eternal Summer-|Free! - Eternal Summer|Free! - Iwatobi Swim Club 2|Free! 2nd Season
Вінець Грiхiв: Втрачене різдво - Епізод у портовому місті↑ギルティクラウン ロストクリスマス an episode of port town|Guilty Crown: Lost Christmas
Вінець грiхiв / Вінець Провини↑ギルティクラウン|Guilty Crown|GUILTY CROWN
Вінець гріхів: Втрачене різдво - Епізод у портовому місті↑ギルティクラウン ロストクリスマス an episode of port town|Guilty Crown: Lost Christmas
Віолета Еверґарден / Вайолет Еверґарден↑ヴァイオレット・エヴァーガーデン|Violet Evergarden
Віолета Еверґарден. Вічність і автозапам’ятовуюча лялька↑ヴァイオレット・エヴァーガーデン 外伝 -永遠と自動手記人形-|Violet Evergarden: Eternity and the Auto Memory Doll|Violet Evergarden Side Story: Eternity and the Auto Memory Doll
Віолета Еверґарден. Фільм↑劇場版 ヴァイオレット・エヴァーガーデン|Violet Evergarden: The Movie|Gekijouban Violet Evergarden
Віолета Еверґарден: Вічність і автозапам’ятовуюча лялька↑ヴァイオレット・エヴァーガーデン 外伝 -永遠と自動手記人形-|Violet Evergarden: Eternity and the Auto Memory Doll|Violet Evergarden Side Story: Eternity and the Auto Memory Doll
Віолета Еверґарден: Вічність і автозапам’ятовуюча лялька↑ヴァイオレット・エヴァーガーデン 外伝 -永遠と自動手記人形-|Violet Evergarden: Eternity and the Auto Memory Doll|Violet Evergarden Side Story: Eternity and the Auto Memory Doll
Віолета Еверґарден: Фільм↑劇場版 ヴァイオレット・エヴァーガーデン|Violet Evergarden: The Movie|Gekijouban Violet Evergarden
Вітаємо в Парадокс Лайв↑Paradox Live THE ANIMATION|Paradox Live the Animation
Вітаємо в пеклі, Ірумо (2 сезон)↑魔入りました！入間くん|Welcome to Demon School! Iruma-kun Season 2|Welcome to Demon School! Iruma-kun 2nd Season
Вітаємо в пеклі, Ірумо (3 сезон)↑魔入りました！入間くん|Welcome to Demon School! Iruma-kun Season 3|Welcome to Demon School! Iruma-kun 3rd Season
Вітер дужчає|Здійнявся вітер↑風立ちぬ|The Wind Rises|Kaze Tachinu
Вітер дужчає|Здійнявся вітер↑風立ちぬ|The Wind Rises|Kaze Tachinu
Вітер забуття↑風の名はアムネジア|A Wind Named Amnesia|Kaze no Namae wa Amunejia|The Name of the Wind is Amnesia
Вітер забуття↑風の名はアムネジア|A Wind Named Amnesia|Kaze no Namae wa Amunejia|The Name of the Wind is Amnesia
Вітер забуття↑風の名はアムネジア|A Wind Named Amnesia|Kaze no Namae wa Amunejia|The Name of the Wind is Amnesia
Вітролом↑WIND BREAKER|Wind Breaker
Гайвер: Могутня біоброня↑強殖装甲ガイバー|Guyver: The Bioboosted Armor|Guyver: The Bio-boosted Armor
Гайвер: Поза контролем↑強殖装甲ガイバー II|The Guyver: Bio-Booster Armor|Bio-Booster Armor Guyver|The Guyver|Kyoushoku Soukou Guyver|The Guyver Act II|Guyver: The Bio-boosted Armor II
Гайвер: Поза контролем↑強殖装甲ガイバー|Guyver: Out of Control
Галактичний експрес 999↑銀河鉄道９９９|Galaxy Express 999|Ginga Tetsudo 999|Galaxy Express 999 (Movie)|Galaxy Express 999 Movie
Гало: Легенди↑ヘイロー・レジェンズ|Halo Legends|Halo Anime|Halo Animation
Гамівна сорочка↑ストレイト・ジャケット|Strait Jacket
Гармонія↑<harmony/> ハーモニー|Harmony|Project Itoh
Гармонія↑アルモニ|Harmonie|Wakate Animator Ikusei Project|2014 Young Animator Training Project|Anime Mirai 2014
Гелк↑ヘルク|Helck
Геллсінґ / Хеллсінг / Хелсінг↑HELLSING OVA|Hellsing Ultimate
Гелсінґ↑Hellsing [ヘルシング]|Hellsing
Гелсінґ: Світанок↑HELLSING THE DAWN|Hellsing: The Dawn|Hellsing: The Dawn - A supplementary of HELLSING|Hellsing OVA Specials|Hellsing Ultimate Specials|Drifters
Генокібер↑ジェノサイバー|Genocyber
Геніальна вечірка↑ジーニアスパーティー|Genius Party|Shanghai Dragon|Deathtic 4|Doorbell|Limit Cycle|Happy Machine|Baby Blue
Герої шести квітів↑六花の勇者|Rokka: Braves of the Six Flowers|Rokka no Yusha
Геть неробство!↑スキップとローファー|Skip and Loafer
Глибини Чорної Компанії↑迷宮ブラックカンパニー|The Dungeon of Black Company
Глибоке шаленство. Втрачене дитя↑Deep Insanity THE LOST CHILD|Deep Insanity: The Lost Child
Годинник романтики↑ロマンチカ クロック|Romantica Clock|Ribbon x Oha Suta Specials|Ribon x Oha Suta Specials
Голова учради — моя наречена!↑おくさまが生徒会長！|My Wife is the Student Council President!|Oku-sama ga Seito Kaichou!
Гора духовного меча: Банкет зоряного неба↑霊剣山 星屑たちの宴|Reikenzan: Hoshikuzu-tachi no Utage|Spirit Blade Mountain: Feast of the Stardust|Congqian Youzuo Lingjianshan
Гордість зірок↑IDOLY PRIDE|Idoly Pride
Горизонт між порожнечі↑境界線上のホライゾン|Horizon in the Middle of Nowhere|Kyoukai Senjou no Horizon
Горянин: У пошуках помсти↑ハイランダー|Highlander: The Search for Vengeance|Highlander: Vengeance
Горянин: У пошуках помсти|Помста горянина / Горянин: У пошуках помсти↑ハイランダー|Highlander: The Search for Vengeance|Highlander: Vengeance
Горянин: У пошуках помсти↑ハイランダー|Highlander: The Search for Vengeance|Highlander: Vengeance
Гра Дарвіна↑ダーウィンズゲーム|Darwin's Game
Гра Джокера↑ジョーカー・ゲーム|Joker Game
Гра в друзів↑トモダチゲーム|Tomodachi Game|Friends Game
Грабіжник↑プランダラ|Plunderer
Гравітація / Тяжіння↑グラビテーション|Gravitation
Гріхи Кяшана↑キャシャーン SINS|Casshern Sins
Гуртожиток Іккоку↑めぞん一刻|Maison Ikkoku|Ikkoku House
Гуртожиток вампірів↑ヴァンパイア男子寮|Vampire Dormitory|Vampire Danshiryou|A Vampire Lives in the Dormitory
Гібридна дитина↑ハイブリッド チャイルド|Hybrid Child
Гігант Ґорґ↑巨神ゴーグ〈ジャイアントゴーグ〉|Giant Gorg|Kyoshin Gorg|Kyojin Gorg
Гімнастичний самурай↑体操ザムライ|The Gymnastics Samurai|Taiso Samurai
Д-Фраг!↑ディーふらぐ！|D-Frag!|D-Fragments
ДНК Янгола|Янгол Д.Н. / ДНК Янгола↑Ｄ・Ｎ・ＡＮＧＥＬ|D.N.Angel|DN Angel|DNAngel
ДРАМАтичне вбивство↑ドラマティカル マーダー|DRAMAtical Murder|DMMd
Даллос↑ダロス|Dallos|Darosu|Battle for Moon Station Dallos
Дволика сестричка Умару↑干物妹！うまるちゃん|Himouto! Umaru-chan|My Two-Faced Little Sister
Дволика сестричка Умару (сезон 2)↑干物妹！うまるちゃんR|Himouto! Umaru-chan R|Himouto! Umaru-chan 2nd Season|My Two-Faced Little Sister R
Дев'ятиколірний олень↑九色鹿|Jiu Se Lu|The Nine Colored Deer|A Deer of Nine Colors
Дев'ятнадцять↑NINETEEN 19|Nineteen 19
Дев'ятнадцять↑NINETEEN 19|Nineteen 19
Дев'ятнадцять↑NINETEEN 19|Nineteen 19|Nineteen
Девілмен: Плаксій↑DEVILMAN crybaby|Devilman: Crybaby
Деджі зустрічає дівчину↑でーじミーツガール|"Deji" Meets Girl
Дек0мани↑ユーレイデコ|Yurei Deco|You0 DECO
Декаданс↑デカダンス|Deca-Dence
Детектив Конан Впіймане у її очах↑瞳の中の暗殺者|Case Closed Movie 04: Captured In Her Eyes|Detective Conan Movie 04: Captured in Her Eyes
Детектив Конан Чотирнадцять жертв↑名探偵コナン １４番目の標的|Case Closed Movie 02: The Fourteenth Target|Detective Conan Movie 02: The Fourteenth Target|Meitantei Conan Movie 02: Jyuuyonbanme no Target
Детектив Конан Чотирнадцять жертв↑名探偵コナン １４番目の標的|Case Closed Movie 02: The Fourteenth Target|Detective Conan Movie 02: The Fourteenth Target|Meitantei Conan Movie 02: Jyuuyonbanme no Target|Detective Conan: The Fourteenth Target
Детектив Конан: Історія Хайбари Ай↑名探偵コナン 灰原哀物語～黒鉄（くろがね）のミステリートレイン～|Detective Conan: Ai Haibara's Story - Jet-Black Mystery Train
Детектив Конан: Впіймане у її очах↑瞳の中の暗殺者|Case Closed Movie 04: Captured In Her Eyes|Detective Conan Movie 04: Captured in Her Eyes|Detective Conan: Captured in Her Eyes
Детектив Конан: Замінований хмарочос↑名探偵コナン 時計じかけの摩天楼|Case Closed Movie 01: The Time Bombed Skyscraper|Detective Conan Movie 01: The Timed Skyscraper
Детектив Конан: Замінований хмарочос↑名探偵コナン 時計じかけの摩天楼|Case Closed Movie 01: The Time Bombed Skyscraper|Detective Conan Movie 01: The Timed Skyscraper|Detective Conan: The Time Bombed Skyscraper
Детектив-медіум Якумо↑心霊探偵 八雲|Psychic Detective Yakumo|Shinrei Tantei Yakumo
Детективне агентство Лі↑鲤氏侦探事务所|Lee's Detective Agency: A Day in Lungmen|Lee Tantei Jimusho|リー探偵事務所
Детройт Місто Металу / Детройт метал сіті↑デトロイト・メタル・シティ|Detroit Metal City|DMC
Джинг - король злодіїв. На сьомому небі↑王ドロボウ JING in Seventh Heaven|Jing: King of Bandits - Seventh Heaven
Джюоосей↑獣王星|Jyu-Oh-Sei: Planet of the Beast King|Juuousei|Jyu Oh Sei
Джібіейт↑ジビエート|Gibiate
Дзиґа↑ばらかもん|Barakamon
Дивне таксі↑オッドタクシー|Odd Taxi
Диво зоряного неба↑星空キセキ|Hoshizora Kiseki
Дивовижна юність сиблінгів↑Super Seisyun Brothers -超青春姉弟s-|Super Seisyun Brothers|SSB|Super Seishun Brothers
Дивовижне космічне кохання↑언빌리버블 스페이스 러브|Unbelievable Space Love
Дитина улюбленця / Моя зірка↑【推しの子】|[Oshi No Ko]|My Star
Дитя погоди↑天気の子|Weathering with You
Дитя погоди↑天気の子|Weathering with You|Tenki no Ko / Weathering with You
Дитя хаосу↑CHAOS;CHILD|ChäoS;Child|Chaos Child
Диявол теж плаче↑デビル メイ クライ|Devil May Cry|Devil May Cry: The Animated Series|DmC
Дияволичка Мемумему↑悪魔のメムメムちゃん|Akuma no Memumemu-chan
Диявольські коханці↑DIABOLIK LOVERS|Diabolik Lovers|DiaLover
Диявольські коханці: Більше крові↑DIABOLIK LOVERS MORE,BLOOD|Diabolik Lovers II: More,Blood|Diabolik Lovers 2nd Season|Diabolik Lovers Second Season|Diabolik Lovers: More Blood
Добраніч, світе↑グッド・ナイト・ワールド|Good Night World
Догма дракона↑ドラゴンズドグマ|Dragon's Dogma
Додому!↑HOME!|Home!|Anime no Tane 2021
Доктор Стоун (1 сезон)↑ドクターストーン|Dr. Stone
Доктор Стоун: Новий світ (3 сезон)↑Dr.STONE NEW WORLD|Dr. Stone 3rd Season
Доктор Стоун: Рюсуй↑Dr.STONE 龍水|Dr. Stone: Ryusui
Доктор Стоун: Рюсуй↑Dr.STONE 龍水|Dr. Stone: Ryusui|Dr. Stone: Ryuusui
Доктор Стоун: Рюсуй↑Dr.STONE 龍水|Dr. Stone: Ryusui
Доля / Великий наказ: Остання сингулярність - Великий храм часу: Соломон↑Fate/Grand Order -終局特異点 冠位時間神殿ソロモン-|Fate/Grand Order: Final Singularity - Grand Temple of Time: Solomon
Доля/Апокриф↑Fate/Apocrypha|Fate/Apocrypha Recaps|Fate/Apocrypha Recap|Fate/Apocrypha Episode 12.5|Fate/Apocrypha Episode 19.5
Доля/Великий Наказ: Камелот. Мандрівка↑劇場版Fate/Grand Order -神聖円卓領域キャメロット- Wandering; Agateram|Fate/Grand Order: Divine Realm of the Round Table - Camelot Wandering; Agateram
Доля/Великий Наказ: Камелот. Паладін↑劇場版Fate/Grand Order -神聖円卓領域キャメロット- Paladin; Agateram|Fate/Grand Order: Divine Realm of the Round Table - Camelot Paladin; Agateram
Доля/Великий карнавал↑Fate/Grand Carnival 第一特異宴 英霊限界大祭オリンピア|Fate/Grand Carnival|Fate/Grand Carnival: Dai-1 Tokuien Eirei Genkai Taisai Olympia
Доля/Великий наказ - Перший наказ↑Fate/Grand Order -First Order-|Fate/Grand Order -First Order-
Доля/Великий наказ - Перший наказ↑Fate/Grand Order -First Order-|Fate/Grand Order: First Order
Доля/Великий наказ - Перший наказ↑Fate/Grand Order -First Order-
Доля/Дивна підробка: Вранішній шепіт↑Fate/strange Fake -Whispers of Dawn-|Fate/strange Fake: Whispers of Dawn
Доля/Дівчинка-чарівниця Ілія↑Fate/kaleid liner プリズマ☆イリヤ|Fate/Kaleid Liner Prisma Illya
Доля/Дівчинка-чарівниця Ілія (2 сезон, 1 частина)↑Fate/kaleid liner プリズマ☆イリヤ ツヴァイ!|Fate/Kaleid Liner Prisma Illya 2Wei!|Prisma Illya 2wei!|Prisma☆Illya 2nd Season
Доля/Дівчинка-чарівниця Ілія: Клятва під снігом↑劇場版 Fate/kaleid liner プリズマ☆イリヤ 雪下の誓い|Fate/kaleid liner Prisma Illya: Vow in the Snow|Fate/kaleid liner Prisma☆Illya Movie: Oath Under Snow
Доля/Дівчинка-чарівниця Ілія: Клятва під снігом↑劇場版 Fate/kaleid liner プリズマ☆イリヤ 雪下の誓い|Fate/kaleid liner Prisma Illya: Vow in the Snow|Fate/kaleid liner Prisma☆Illya Movie: Oath Under Snow|Fate/kaleid liner Prisma☆Illya: Vow in the Snow
Доля/Дівчинка-чарівниця Ілія: Клятва під снігом↑劇場版 Fate/kaleid liner プリズマ☆イリヤ 雪下の誓い|Fate/kaleid liner Prisma Illya: Vow in the Snow|Fate/kaleid liner Prisma☆Illya Movie: Oath Under Snow
Доля/Екстра: Востаннє на біс↑Fate/EXTRA Last Encore|Fate/Extra: Last Encore
Доля/Ніч битви↑Fate/stay night|Fate/stay night TV Reproduction|Fate/stay night Recap|Fate/stay night OVA
Доля/Ніч битви: Дотик небес. Частина 1: Віща квітка↑劇場版「Fate/stay night [Heaven's Feel] Ⅰ.presage flower」|Fate/stay night: Heaven's Feel - I. Presage Flower
Доля/Ніч битви: Дотик небес. Частина 1: Віща квітка↑劇場版「Fate/stay night [Heaven's Feel] Ⅰ.presage flower」|Fate/stay night: Heaven's Feel - I. Presage Flower|Fate/stay night: Heaven's Feel I. Presage Flower
Доля/Ніч битви: Дотик небес. Частина 2: Загублений метелик↑劇場版「Fate/stay night [Heaven's Feel] II.lost butterfly」|Fate/stay night: Heaven's Feel - II. Lost Butterfly|Fate/stay night Movie: Heaven's Feel 2
Доля/Ніч битви: Дотик небес. Частина 2: Загублений метелик↑劇場版「Fate/stay night [Heaven's Feel] II.lost butterfly」|Fate/stay night: Heaven's Feel - II. Lost Butterfly|Fate/stay night Movie: Heaven's Feel 2|Fate/stay night: Heaven's Feel II. Lost Butterfly
Доля/Ніч битви: Дотик небес. Частина 3: Весняна пісня↑劇場版「Fate/stay night [Heaven's Feel] III.spring song」|Fate/stay night: Heaven's Feel - III. Spring Song|Fate/stay night Movie: Heaven's Feel 3
Доля/Ніч битви: Дотик небес. Частина 3: Весняна пісня↑劇場版「Fate/stay night [Heaven's Feel] III.spring song」|Fate/stay night: Heaven's Feel - III. Spring Song|Fate/stay night Movie: Heaven's Feel 3|Fate/stay night: Heaven's Feel III. Spring Song
Доля/Ніч битви: Світ нескінченних клинків (1 сезон)↑劇場版 Fate/stay night UNLIMITED BLADE WORKS|Fate/stay night: Unlimited Blade Works|Gekijouban Fate/Stay Night: Unlimited Blade Works|Fate/stay night Movie|Fate/stay night UBW
Доля: дивна Фальшивка. Світанковий шепіт↑Fate/strange Fake -Whispers of Dawn-|Fate/strange Fake: Whispers of Dawn
Доля: дивна Фальшивка. Світанковий шепіт↑Fate/strange Fake -Whispers of Dawn-|Fate/strange Fake: Whispers of Dawn
Домініон: Танкова поліція↑ドミニオン|Dominion|Dominion Tank Police
Дораемон↑ドラえもん|Doraemon|Doraemon (1973)
Дороро↑どろろと百鬼丸|Dororo|Dororo and Hyakkimaru
Досконала журба↑パーフェクトブルー|Perfect Blue
Досконала журба↑パーフェクトブルー|Perfect Blue
Досьє Лорда Ель-Мелоя ІІ↑ロード・エルメロイⅡ世の事件簿 -魔眼蒐集列車 Grace note-|Lord El-Melloi II's Case Files: Rail Zeppelin Grace Note
Досягти Терри↑地球へ...|Toward the Terra|Terra he... (Movie)
Дощ у сонячному світлі↑陽なたのアオシグレ|Sonny Boy & Dewdrop Girl|Rain in the Sunshine
Дракон і Принцеса з Ластовинням↑竜とそばかすの姫|Belle|Ryuusoba
Драґонбол супер: Бролі|Перли дракона Супер: Бролі↑ドラゴンボール超（スーパー） ブロリー|Dragon Ball Super: Broly
Друга молодість дідуся та бабусі↑じいさんばあさん若返る|Grandpa and Grandma Turn Young Again|Ojiisan to Obaasan ga Wakagaetta Hanashi|A Story About a Grandpa and Grandma Who Returned Back to Their Youth
Дух у Латах: С.С. - С.С.С. Дух у Латах: Синдром Самітника - Суспільство Спаяного Стану↑攻殻機動隊 STAND ALONE COMPLEX Solid State Society|Ghost in the Shell: Stand Alone Complex - Solid State Society|GitS SAC SSS|GitS: SAC 3|gits sac3|gitssac3|sac3|sss|Ghost in the Shell S.A.C. Solid State Society
Дух у Латах: Синдром Самітника - Суспільство Спаяного Стану↑攻殻機動隊 STAND ALONE COMPLEX Solid State Society|Ghost in the Shell: Stand Alone Complex - Solid State Society|GitS SAC SSS|GitS: SAC 3|gits sac3|gitssac3|sac3|sss|Ghost in the Shell S.A.C. Solid State Society
Дюгонь Дюдя↑ぷかぷかジュジュ|Pukapuka Juju|Pukapuka Dudu|Wakate Animator Ikusei Project|2011 Young Animator Training Project|Anime Mirai 2011|Dudu the Floater|Dudu the Floatie
Дюрарара! Х2 Хаос!↑デュラララ!!×２ 承|Durarara!! x2 Shou|Durarara!! 2nd Season|DRRR!! 2nd Season|Durararax2 1st Arc
Дюрарара!!↑デュラララ!!|Durarara!!|Dhurarara!!|Dyurarara!!|Dulalala!!|Dullalala!!|DRRR!!
Дядько і зефірки↑おじさんとマシュマロ|Ojisan and Marshmallow|Oji-san to Marshmallow
Дятлове детективне агентство↑啄木鳥探偵處|Woodpecker Detective's Office|Kitsutsuki Tantei-Dokoro
Ді Ґрей-мен (ТБ-1)↑ディー・グレイマン|D.Gray-man|D. Gray-man|D. Grey-man
Ді.Ґрей-мен: Святі (ТБ-2)↑ディー・グレイマン ハロー|D.Gray-man HALLOW
Діва Розена, Діви Розена (сезон 1)↑ローゼンメイデン|Rozen Maiden
Діва Розена, Діви Розена: Перезаведення (сезон 3)↑ローゼンメイデン (2013)|Rozen Maiden: Zurückspulen
Діва Розена, Діви Розена: Сни (сезон 2)↑ローゼンメイデン トロイメント|Rozen Maiden: Träumend|Rozen Maiden 2
Дівки з Задвірків↑Back Street Girls -ゴクドルズ|Back Street Girls: Gokudols|Back Street Girls: Washira Idol Hajimemashita.|Gokudols
Дівчата & Танки: Битва за Арісу↑ガールズ＆パンツァー 劇場版|Girls und Panzer der Film Specials|Girls und Panzer der Film: Arisu War!|Girls und Panzer: Fushou Akiyama Yukari no Sensha Kouza
Дівчата & Танки: Війна таякі↑ガールズ＆パンツァー 最終章|Girls & Panzer: Saishuushou Part 2 Specials|Girls und Panzer das Finale OVA|Girls & Panzer: Taiyaki War!|Girls & Panzer: 1-pun Chotto de Wakaru!!|Fushou Akiyama Yukari no Sensha Kouza: Eikou no France Sensha-hen|The Humble Akiyama Yukari's Tank Course: Glorious French Tanks Chapter
Дівчата з театру Ракуґо↑じょしらく|Joshiraku|Rakugo Girls
Дівчата і танки: Битва за дайкон!↑『ガールズ＆パンツァー 最終章』第3話|Girls & Panzer: Saishuushou Part 3 Specials|Girls und Panzer das Finale OVA|Girls & Panzer: Daikon War!|Fushou Akiyama Yukari no Sensha Kouza: Unique na Suiriku Ryouyou Sensha-hen|The Humble Akiyama Yukari's Tank Course: Unique Amphibious Tank
Дівчата і танки: Справжній матч з Анціо! -Лекція Акіями Юкарі на тему італійських танків↑ガールズ&パンツァー これが本当のアンツィオ戦です！ 不肖･秋山優花里の戦車講座～イタリア戦車編～|Girls & Panzer: Kore ga Hontou no Anzio-sen desu! - Fushou Akiyama Yukari no Sensha Kouza|Girls und Panzer: Akiyama Yukari's Tank Course|Girls und Panzer: Akiyama Yukari's Tank Corner|Girls und Panzer: This is the true battle of Anzio! Italy Sensha-hen
Дівчата і танки: Танковий курс Акіями Юкарі↑ガールズ＆パンツァー 不肖・秋山優花里の戦車講座|Girls & Panzer: Fushou Akiyama Yukari no Sensha Kouza|Girls und Panzer: Akiyama Yukari's Tank Course|Girls und Panzer: Akiyama Yukari's Tank Corner
Дівчата-скелелази↑いわかける！ -Sport Climbing Girls-|Iwa Kakeru! Sport Climbing Girls|Hang On! Climbing Girls
Дівчатка в окулярах↑眼鏡なカノジョ|Megane na Kanojo|Gankyou na Kanojo|Glasses Girlfriends
Дівчатка з Хоккайдо дуже милі↑道産子ギャルはなまらめんこい|Hokkaido Gals Are Super Adorable!|Dosanko Gyaru Is Mega Cute
Дівчачий табір (Сезон 3)↑ゆるキャン△ SEASON3|Laid-Back Camp Season 3|Yuru Camp 3rd Season
Дівчина Боббі↑ボビーに首ったけ|Bobby ni Kubittake|Bobby's Girl|Bobby's In Deep
Дівчина Боббі↑ボビーに首ったけ|Bobby ni Kubittake|Bobby's Girl|Bobby's In Deep
Дівчина Боббі↑ボビーに首ったけ|Bobby ni Kubittake|Bobby's Girl|Bobby's In Deep
Дівчина з Того Боку↑とつくにの少女|The Girl From the Other Side|Siúil|a Rún OVA|Totsukuni no Shoujo OAD
Дівчина з Того Боку↑とつくにの少女|The Girl From the Other Side|Siúil|a Rún OVA|Totsukuni no Shoujo OAD|The Girl from the Other Side
Дівчина з Того Боку↑とつくにの少女|The Girl From the Other Side|Siúil|a Rún OVA|Totsukuni no Shoujo OAD
Дівчина-циклоп Сайпу↑サイクロプス少女さいぷ～|Cyclops Shoujo Saipuu|Cyclops Shoujo Saipu|Cyclops Girl Cypu
Дівчинка з Потойбіччя↑とつくにの少女|The Girl From the Other Side|Siúil|a Rún OVA|Totsukuni no Shoujo OAD
Дівчинка, що бачить↑見える子ちゃん|Mieruko-chan
Дівчинка, що стрибала крізь час↑時をかける少女|The Girl Who Leapt Through Time|Toki wo Kakeru Shojo|TokiKake|Toki o Kakeru Shojo|The Girl Who Cut Time|The Little Girl Who Conquered Time
Дівчинка, що стрибала крізь час↑時をかける少女|The Girl Who Leapt Through Time|Toki wo Kakeru Shojo|TokiKake|Toki o Kakeru Shojo|The Girl Who Cut Time|The Little Girl Who Conquered Time
Дівчинка, що стрибала крізь час↑時をかける少女|The Girl Who Leapt Through Time|Toki wo Kakeru Shojo|TokiKake|Toki o Kakeru Shojo|The Girl Who Cut Time|The Little Girl Who Conquered Time
Дівчинка-вбивця↑ガンスリンガー・ガール|Gunslinger Girl|Gunslinger Girls
Дівчинка-вбивця. Ляльковий театр↑ガンスリンガー ガール -IL TEATRINO-|Gunslinger Girl: Il Teatrino|Gunslinger Girl 2nd Season|Gunslinger Girl Second
Дівчинка-супутник і молочна корова↑우리별 일호와 얼룩소|Satellite Girl and Milk Cow|Ooleebyeol ilhowa eollugso
Дівчинка-супутник і молочна корова↑우리별 일호와 얼룩소|Satellite Girl and Milk Cow|Ooleebyeol ilhowa eollugso|The Satellite Girl and Milk Cow
Дівчинка-супутник і молочна корова↑우리별 일호와 얼룩소|Satellite Girl and Milk Cow|Ooleebyeol ilhowa eollugso
Дівчинка-чарівнофренія↑せいぜいがんばれ！魔法少女くるみ|Seizei Ganbare! Mahou Shoujo Kurumi
Дідуган Зед↑老人Ｚ|Roujin Z|Old Man Z
Діти, що женуться за зорями↑星を追う子ども|Children Who Chase Lost Voices|Children who Chase Lost Voices from Deep Below|Journey to Agartha
Діти, що женуться за зорями↑星を追う子ども|Children Who Chase Lost Voices|Children who Chase Lost Voices from Deep Below|Journey to Agartha
Еванґеліон. Перебудова↑シン・エヴァンゲリオン劇場版:|||Evangelion: 3.0+1.0 Thrice Upon a Time|Evangelion: 4.0|Rebuild of Evangelion|Shin Evangelion Gekijouban: |||Rebuild of Evangelion: Final
Егоїст високої специфікації↑ワガママハイスペック|Wagamama High Spec
Едем↑エデン|Eden (ONA)
Екс-Арм↑EX-ARMエクスアーム|Ex-Arm
Експерименти Лейн↑シリアルエクスペリメンツレイン|Serial Experiments Lain
Ельфійська пісня↑エルフェンリート|Elfen Lied|Elfen Song|Elfic Song|Elf Song
Елісон та Лілія↑アリソンとリリア|Allison & Lillia|Alison and Lilia|Arison to Riria|Allison and Lillia
Ендро↑えんどろ～！|ENDRO!|Endoro~!
Ерго Проксі↑エルゴプラクシー|Ergo Proxy
Ероманґа сенсей↑エロマンガ先生|Eromanga Sensei
Ескафлон↑エスカフローネ|Escaflowne: A Girl in Gaea|Escaflowne: The Movie
Естетика героя-вигнанця↑はぐれ勇者の鬼畜美学〈エステティカ〉|Aesthetica of a Rogue Hero|Hagure Yuusha no Estetica
Еф - історія спогадів↑ef - a tale of memories.|ef - a tale of memories
Еф: історія мелодій↑ef - a tale of melodies.|ef - a tale of melodies|ef: A Tale of Memories Second Season|ef: A Tale of Memories 2nd Season
Жозе, тигр і риба / Її завітна мрія↑ジョゼと虎と魚たち|Josee, the Tiger and the Fish
Журнал теплих моментів, Журнал теплих почуттiв↑ほのぼのログ|Honobono Log
З любов'ю Хіна: Різдвяна історія↑ラブひなクリスマススペシャル ～サイレント・イヴ～|Love Hina Christmas Movie
З макових схилів / Зі схилів Кокуріко↑コクリコ坂から|From Up on Poppy Hill|Coquelicot-zaka kara|Kokuriko-saka kara|Kokuriko-zaka kara|Coquelicot Saka kara|Kokurikozaka kara
З макових схилів / Зі схилів Кокуріко↑コクリコ坂から|From Up on Poppy Hill|Coquelicot-zaka kara|Kokuriko-saka kara|Kokuriko-zaka kara|Coquelicot Saka kara|Kokurikozaka kara|From Up on Poppy Hill / Kokuriko-zaka kara
З милості Богів↑神達に拾われた男|By the Grace of the Gods|The man picked up by the gods|Kamihiro|Kamitachi ni Hirowareta Otoko
З милості Богів 2↑神達に拾われた男|By the Grace of the Gods 2|The man picked up by the gods 2nd Season|Kamihiro 2nd Season|Kamitachi ni Hirowareta Otoko 2nd Season
З нового світу↑新世界より|From the New World|Shin Sekai Yori
З'єднайся зі мною!↑なつなぐ!|Natsunagu!
За гранню: Я буду поряд - Минуле↑劇場版 境界の彼方 I'LL BE HERE 過去篇|Beyond the Boundary: I'll Be Here - Past|Beyond the Boundary Movie|Kyokai no Kanata Movie|Beyond the Boundary: I'll Be Here Past
За межею небес↑蒼天航路|Beyond the Heavens|Soten Koro
Заборонене тату↑タブー・タトゥー|Taboo Tattoo
Забігайлівка «Медуза»↑クラゲの食堂|Kurage no Shokudou|Jellyfish Restaurant|Jellyfish Diner
Загроза для хлопця No.1↑抱かれたい男1位に脅されています。|DAKAICHI -I'm being harassed by the sexiest man of the year-|Dakaretai Otoko Ichii ni Odosarete Imasu.|Dakaretai Otoko No.1 ni Odosareteimasu
Загугліть, пане Коккурі!↑繰繰れ！コックリさん|GUGURE! KOKKURI-SAN|GuguKoku
Заковане Літописання: Світло Хеккейтаса↑チェインクロニクル～ヘクセイタスの閃〈ひかり〉～|Chain Chronicle: The Light of Haecceitas
Залізна людина: Повстання Техновора↑アイアンマン：ライズ・オブ・テクノヴォア|Iron Man: Rise of Technovore
Залізнична романтика↑レヱル・ロマネスク|Rail Romanesque|Maitetsu
Залізничні війни!↑RAIL WARS! [レールウォーズ]|Rail Wars!
Залізобетон↑鉄コン筋クリート|Tekkonkinkreet|Tekkon Kinkreet (2006)|Black & White|Tekkon Kinkurito|Tekkon Kin Creat
Замальовки Хідамарі x Медові стільники↑ひだまりスケッチ×ハニカム|Hidamari Sketch x Honeycomb|Hidamari Sketch x Hanikamu|Hidamari Sketch Dai Yon Ki|Hidamari Sketch Fourth Series|Hidamari Sketch 4th Season
Замовляли кролика??↑ご注文はうさぎですか??|Is the Order a Rabbit??|Gochuumon wa Usagi desu ka? 2|GochiUsa 2
Заморозка↑フリージング|Freezing
Запис↑レック|Rec
Запис Дубля↑Obey Me!
Записки робототехніки↑ロボティクス・ノーツ|Robotics;Notes
Записник Бога↑神様のメモ帳|Heaven's Memo Pad|It's the Only NEET Thing to Do|Kami-sama no Memo-chou|God's Notebook|Notebook of God
Записник Смерті / Зошит смерті↑デスノート|Death Note|DN
Зараз і потім, тут і там↑今、そこにいる僕|Now and Then, Here and There|Ima|Soko ni Iru Boku
Заспівай мені про любов↑アイの歌声を聴かせて|Sing a Bit of Harmony
Заспівай мені про любов↑アイの歌声を聴かせて|Sing a Bit of Harmony
Збочена експериментальна анімаційна Ексаль Сага↑へっぽこ実験アニメーション エクセル♥サーガ|Excel Saga|Heppoko Jikken Animation Excel♥Saga
Зв'язок принцес: Повторне занурення↑プリンセスコネクト！Re:Dive|Princess Connect! Re:Dive|Priconne
Зв'язок принцес: Повторне занурення 2↑プリンセスコネクト! Re:Dive Season 2|Princess Connect! Re:Dive Season 2|Princess Connect! Re:Dive 2nd Season|Priconne 2nd Season
Зворушливий комплекс↑ラブ★コン|Lovely Complex|Love★Com|Love Com
Звук Неба↑ソ・ラ・ノ・ヲ・ト|Sound of the Sky|So-Ra-No-Wo-To|Soranowoto|Sora no Woto|Sora no Oto
Звільнення↑オリエント|Orient
Звірячий інцидент↑怪物事変|Kemono Jihen|Monster Incidents
Зелені дні. Динозавр і Я↑소중한 날의 꿈|Green Days: Dinosaur and I|So-jjoong-han Nam-eui Ggoom
Зетмен↑ゼットマン|Zetman
Зеґапейн↑ゼーガペイン|Zegapain
Зламаний Меч↑ブレイク ブレイド|Broken Blade
Злодійка-камікадзе Жанна↑神風怪盗ジャンヌ|Kamikaze Kaitou Jeanne|Phantom Thief Jeanne|Divine Wind Thief Jeanne
Злощасне життя псионіка Сайкі↑斉木楠雄のΨ難|The Disastrous Life of Saiki K|Saiki Kusuo no Psi Nan|Saiki Kusuo no Sainan
Злощасне життя псионіка Сайкі (2 сезон)↑斉木楠雄のΨ難 2|The Disastrous Life of Saiki K. 2|Saiki Kusuo no Psi Nan 2
Змилуйтеся наді мною, могутній Лорде!↑大王饶命|Spare Me, Great Lord!|Dawang Raoming
Знак Тесли↑テスラノート|Tesla Note
Зниклі феї↑Fairy gone フェアリーゴーン|Fairy Gone
Зникнення Сузумії Харухі↑涼宮ハルヒの消失|The Disappearance of Haruhi Suzumiya|The Vanishment of Haruhi Suzumiya|Suzumiya Haruhi no Syoshitsu|Haruhi Movie
Знущання↑いじめ 〜いけにえの教室〜|Ijime: Ikenie no Kyoushitsu
Золоте божество (1 сезон)↑ゴールデンカムイ|Golden Kamuy
Золотий жевжик↑ゴールデンボーイ|Golden Boy
Золочений чорний ключ від зачинених дверей↑黒と金の開かない鍵。|Kuro to Kin no Akanai Kagi.|Kuro to Kin no Hirakanai Kagi
Зомбі-кредит↑ZOMBIE-LOAN ゾンビローン|Zombie-Loan
Зомбіленд Саґа↑ゾンビランドサガ|Zombie Land Saga
Зона 88↑エリア88|Area 88|Area 88 OVA
Зона-6 / 6-та зона↑NO.6［ナンバー・シックス］|No. 6|Number Six|Number 6|No. Six
Зоомагазин жахів↑Pet Shop of Horrors (ペットショップ・オブ・ホラーズ)|Pet Shop of Horrors
Зоряний десант: Вторгнення↑スターシップ・トゥルーパーズ インベイジョン|Starship Troopers: Invasion
Зоряний десант: Зрадник Марса↑スターシップ・トゥルーパーズ レッドプラネット|Starship Troopers: Traitor of Mars|Starship Troopers: Kasei no Uragirimono
Зоряний шлях. Народження↑星界の断章 “誕生”|Crest of the Stars: Birth|Seikai no Danshou: Birth|Passage of the Stars: Birth|Seikai no Danshou: Tanjyou|Lost Chapter of the Stars: Birth
Зразок простолюдина↑俺がお嬢様学校に「庶民サンプル」としてゲッツされた件|Shomin Sample|Story in Which I Was Kidnapped by a Young Lady's School to be a "Sample of the Common People"|Ore ga Ojou-sama Gakkou ni "Shomin Sample" Toshite Rachirareta Ken
Зроби це сам!!↑Do It Yourself!! -どぅー・いっと・ゆあせるふ-|Do It Yourself!!|DIY!!
Зростаючий щоденник Нюви↑女娲成长日记|Nuwa Chengzhang Riji|Nuwa Chengchang Riji|Nuwa's Diary
Зруйнований світ. Прокляття святого лицаря↑聖剣使いの禁呪詠唱〈ワールドブレイク〉|World Break: Aria of Curse for a Holy Swordsman|Seiken Tsukai no Kinshuu Eishou|Warubure
Зустріч під літнім снігом↑夏雪ランデブー|Natsuyuki Rendezvous|A Summer Snow Rendezvous
Йо-Кай Вотч / Йокай Вотч↑妖怪ウォッチ|Yo-kai Watch|Yokai Watch
Йобі - п'ятихвоста лисичка↑Cheonnyeon-yeowoo Yeowoobi|Yobi, The Five Tailed Fox|Yobi, The Five Tailed Fox|Cheonnyeon-yeowoo Yeowoobi
Йобі — п’ятихвоста лисичка↑천년여우 여우비|Yobi, The Five Tailed Fox
Йобі — п’ятихвоста лисичка↑천년여우 여우비|Yobi, The Five Tailed Fox|Yobi, The Five-Tailed Fox
Йоко із Сенґоку↑戦国妖狐 世直し姉弟編|Sengoku Youko
Йома: посланці царства темряви↑Youma|Blood Reign: Curse of the Yoma|Curse of the Undead Yoma|Blood Reign: Curse of the Yoma|Youma
Йормунґанд (1 сезон)↑ヨルムンガンド|Jormungand
Кабанері зі сталевої фортеці↑甲鉄城のカバネリ|Kabaneri of the Iron Fortress
Кабанері зі сталевої фортеці: Битва за Унато↑Koutetsujou no Kabaneri Movie 3: Unato Kessen|Kabaneri of the Iron Fortress: The Battle of Unato|Kabaneri of the Iron Fortress: The Battle of Unato|Koutetsujou no Kabaneri Movie 3: Unato Kessen
Кадо: правильна відповідь↑Seikaisuru Kado|KADO: The Right Answer|KADO: The Right Answer|Seikaisuru Kado
Казка про дівчину епохи Тайшьо↑Taishou Otome Otogibanashi|Taisho Otome Fairy Tale|Taishou Maiden Fairytale|Taisho Otome Fairy Tale|Taishou Otome Otogibanashi
Казка про принцесу Кагую↑かぐや姫の物語|The Tale of the Princess Kaguya|Kaguyahime no Monogatari|Princess Kaguya Story
Казка про принцесу Каґую↑かぐや姫の物語|The Tale of the Princess Kaguya|Kaguyahime no Monogatari|Princess Kaguya Story
Казка про принцесу Каґую↑かぐや姫の物語|The Tale of the Princess Kaguya|Kaguyahime no Monogatari|Princess Kaguya Story
Казка про хоробрість↑ブレイブ・ストーリー|Brave Story
Казка про цукрове яблуко↑シュガーアップル・フェアリーテイル|Sugar Apple Fairy Tale
Казка про цукрове яблуко. Частина 2↑シュガーアップル・フェアリーテイル|Sugar Apple Fairy Tale Part 2
Казкова красуня. Забери мене на Місяць: Шкільні дні↑Tonikaku Kawaii: Joshikou-hen|TONIKAWA: Over The Moon For You - High School Days|Tonikaku Kawaii: High School Days|TONIKAWA: Over The Moon For You - High School Days|Tonikaku Kawaii: Joshikou-hen
Казкова красуня: Забери мене на Місяць↑Tonikaku Kawaii|TONIKAWA: Over The Moon For You|Generally Cute, Fly Me to the Moon|TONIKAWA: Over The Moon For You|Tonikaku Kawaii
Казкова красуня: Забери мене на Місяць (Сезон 2)↑Tonikaku Kawaii 2nd Season|TONIKAWA: Over The Moon For You Season 2|TONIKAWA: Over The Moon For You Season 2|Tonikaku Kawaii 2nd Season
Казкова красуня: Забери мене на Місяць. Форма (ОВА)↑Tonikaku Kawaii: Seifuku|TONIKAWA: Over The Moon For You - Uniform|TONIKAWA: Over The Moon For You - Uniform|Tonikaku Kawaii: Seifuku
Кайба↑カイバ|Kaiba
Кайджю №8↑Kaijuu 8-gou|Kaiju No. 8|8Kaijuu, Monster #8, Kaiju No. Eight, Kaiju #8|Kaiju No. 8|Kaijuu 8-gou
Кайджі: Жага вижити↑Gyakkyou Burai Kaiji: Ultimate Survivor|Kaiji: Ultimate Survivor|Tobaku Mokushiroku Kaiji, The Suffering Pariah Kaiji|Kaiji: Ultimate Survivor|Gyakkyou Burai Kaiji: Ultimate Survivor
Кайна з великого сніжного моря↑Ooyukiumi no Kaina|Kaina of the Great Snow Sea|Kaina of the Great Snow Sea|Ooyukiumi no Kaina
Кайт↑A KITE（カイト）|Kite
Кайт-визволителька↑KITE LIBERATOR (カイト リベレイター)|Kite Liberator
Какао дощового кольору↑雨色ココア|Rainy Cocoa|Ameiro Cocoa
Калейдоскоп ілюзій: Спогади Фантома↑幻想万華鏡 ~The Memories Of Phantasm~|Touhou Fantasy Kaleidoscope: The Memories of Phantasm
Каліґула↑CALiGULA|Caligula
Кампіоне!↑カンピオーネ！ ～まつろわぬ神々と神殺しの魔王～|Campione!|Campione!: Matsurowanu Kamigami to Kamigoroshi no Maou
Канна й місяць богів↑神在月のこども|Child of Kamiari Month
Канна й місяць богів↑神在月のこども|Child of Kamiari Month
Каннаґі↑Kannagi|Kannagi: Crazy Shrine Maidens|Kannagi: Crazy Shrine Maidens|Kannagi
Канон (2006)↑Kanon (2006)|Kanon|Kanon Remake, Kanon 2006|Kanon|Kanon (2006)
Капсула часу під сакурою↑サクラカプセル|Sakura Capusule|Sakura Capsule
Карас↑鴉 -KARAS-|Karas|Crow|Raven|Karas: The Prophecy|Karas: The Revelation
Карнавал роботів↑ロボット・カーニバル|Robot Carnival
Карнавал роботів 1 сезон↑ロボット・カーニバル|Robot Carnival
Карнавальний Фантазм↑カーニバル・ファンタズム|Carnival Phantasm
Картоловка Сакура↑カードキャプターさくら|Cardcaptor Sakura|CCS|Cardcaptors|Card Captor Sakura
Картоловка Сакура. Фільм 2↑劇場版 カードキャプターさくら 封印されたカード|Cardcaptor Sakura Movie 2: The Sealed Card|Card Captors Sakura The Movie 2|Card Captor Sakura: Enchanted Cards
Картоловка Сакура: Прозорі Карти — Пролог: Сакура і два ведмеді↑Cardcaptor Sakura: Clear Card-hen Prologue - Sakura to Futatsu no Kuma|Cardcaptor Sakura: Clear Card Prologue – Sakura and the Two Bears|Cardcaptor Sakura: Clear Card Prologue – Sakura and the Two Bears|Cardcaptor Sakura: Clear Card-hen Prologue - Sakura to Futatsu no Kuma
Картоловка Сакура: Фільм↑劇場版 カードキャプターさくら|Cardcaptor Sakura The Movie|Card Captor Sakura|Cardcaptors: The Movie
Касе-сан та Ранкове Сяйво↑あさがおと加瀬さん。|Kase-san and Morning Glories|Morning Glory and Kase-san
Касе-сан та Ранкове Сяйво↑あさがおと加瀬さん。|Kase-san and Morning Glories|Morning Glory and Kase-san
Касе-сан та Ранкове Сяйво↑Asagao to Kase-san.|Kase-san and Morning Glories|Morning Glory and Kase-san|Kase-san and Morning Glories|Asagao to Kase-san.
Кафе «У Білого Ведмедя»↑しろくまカフェ|Polar Bear Cafe|Polar Bear Café|Shirokuma Café
Каґуя хоче, щоб їй зізналися ~Війна любові та розуму геніїв~ (Сезон 2)↑Kaguya-sama wa Kokurasetai? Tensai-tachi no Renai Zunousen|Kaguya-sama: Love is War Season 2|Kaguya Wants to be Confessed To: The Geniuses' War of Love and Brains 2nd Season, Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen 2nd Season, Kaguya-sama: Love is War 2nd Season|Kaguya-sama: Love is War Season 2|Kaguya-sama wa Kokurasetai? Tensai-tachi no Renai Zunousen
Каґуя хоче, щоб їй зізналися ~Ультра-романтика~ (Cезон 3)↑かぐや様は告らせたい-ウルトラロマンティック-|Kaguya-sama: Love is War - Ultra Romantic|Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen 3rd Season|Kaguya-sama: Love is War Season 3rd Season
Каґуя-сама, Кохання як війна / Каґуя хоче, щоб їй зізналися ~Війна любові та розуму геніїв~↑Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen|Kaguya-sama: Love is War|Kaguya Wants to be Confessed To: The Geniuses' War of Love and Brains|Kaguya-sama: Love is War|Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen
Каґінадо↑かぎなど|Kaginado
Квартет Потраплянців↑異世界かるてっと|Isekai Quartet
Квартет нічної Сакури↑夜桜四重奏 ～ヨザクラカルテット～|Yozakura Quartet|Yozakura Shijuusou|Quartet of Cherry Blossoms in the Night
Квартира-студія з хорошим освітленням і янголом на додачу↑One Room, Hiatari Futsuu, Tenshi-tsuki.|Studio Apartment, Good Lighting, Angel Included|Studio Apartment, Good Lighting, Angel Included|One Room, Hiatari Futsuu, Tenshi-tsuki.
Квасолина Котишлях↑ライディング・ビーン|Riding Bean
Квіти зла↑惡の華|Flowers of Evil|Aku no Hana
Кейджьо!!!↑Keijo!!!!!!!!|Keijo!!!!!!!!|Keijo!!!!!!!!
Кемурікуса - Димна трава↑ケムリクサ|Kemurikusa (TV)
Кенді Кенді↑キャンディ・キャンディ|Candy Candy
Кенді бой↑Candy boy -Nonchalant talk of the certain twin sisters in daily life-|Candy Boy: Nonchalant Talk of the Certain Twin Sisters in Daily Life|CB
Керол і Т'юздей↑キャロル&チューズデイ|Carole & Tuesday
Кишенькові Монстри Сонце та Місяць↑ポケットモンスター サン＆ムーン|Pokémon the Series: Sun & Moon|Pocket Monsters Sun & Moon|Pokémon Sun & Moon
Клан п’яти листків↑さらい屋 五葉|House of Five Leaves|Sarai-ya Goyou
Кланнад↑CLANNAD|Clannad
Клас героїв↑Eiyuu Kyoushitsu|Classroom for Heroes|Class Room✿For Heroes, Hero Classroom|Classroom for Heroes|Eiyuu Kyoushitsu
Клас убивць / Клас вбивць (1 сезон)↑Ansatsu Kyoushitsu|Assassination Classroom|Assassination Classroom|Ansatsu Kyoushitsu
Клас убивць / Клас вбивць (2 сезон)↑暗殺教室　第２期|Assassination Classroom Second Season|Ansatsu Kyoushitsu Season 2|Ansatsu Kyoushitsu Final Season
Клеймор↑クレイモア|Claymore
Клин кохання↑間の楔|Ai no Kusabi|Love Wedge|The Space Between|Wedge of interval|Wedge of Love
Клинок Безсмертного↑Mugen no Juunin: Immortal|Blade of the Immortal|Blade of the Immortal|Mugen no Juunin: Immortal
Клинок і душа↑ブレイドアンドソウル|Blade & Soul|Blade and Soul
Клинок, який знищує демонів↑Kimetsu no Yaiba|Demon Slayer: Kimetsu no Yaiba|Blade of Demon Destruction|Demon Slayer: Kimetsu no Yaiba|Kimetsu no Yaiba
Клинок, який знищує демонів: Арка Нескінченного потяга↑劇場版 鬼滅の刃 無限列車編|Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train|Gekijouban Kimetsu no Yaiba: Mugen Ressha-hen|Kimetsu no Yaiba: Infinity Train|Demon Slayer Movie: Infinity Train
Клинок, який знищує демонів: Арка Нескінченного потяга↑劇場版 鬼滅の刃 無限列車編|Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train|Gekijouban Kimetsu no Yaiba: Mugen Ressha-hen|Kimetsu no Yaiba: Infinity Train|Demon Slayer Movie: Infinity Train|Demon Slayer -Kimetsu no Yaiba- The Movie: Mugen Train
Клинок, який знищує демонів: Арка Нескінченного потяга↑Kimetsu no Yaiba Movie: Mugen Ressha-hen|Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train|Gekijouban Kimetsu no Yaiba: Mugen Ressha-hen, Kimetsu no Yaiba: Infinity Train, Demon Slayer Movie: Infinity Train|Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train|Kimetsu no Yaiba Movie: Mugen Ressha-hen
Клинок, який знищує демонів: Арка селище ковалів (3 сезон)↑Kimetsu no Yaiba: Katanakaji no Sato-hen|Demon Slayer: Kimetsu no Yaiba Swordsmith Village Arc|Demon Slayer: Kimetsu no Yaiba Swordsmith Village Arc|Kimetsu no Yaiba: Katanakaji no Sato-hen
Клуб Ейкен↑Eiken: Eikenbu yori Ai wo Komete|Eiken|Eiken: From Eiken With Love|Eiken|Eiken: Eikenbu yori Ai wo Komete
Клуб Раймана↑Ryman's Club|Salaryman's Club|Salaryman's Club|Ryman's Club
Клуб легкої музики (Сезон 2)↑K-On!!|K-ON! Season 2|Keion 2, K-On!! 2nd Season|K-ON! Season 2|K-On!!
Клуб легкої музики! (Кей-Он!)↑けいおん!|K-ON!|Keion|K-ON! Season 1
Клуб настільних ігор↑放課後さいころ倶楽部|After School Dice Club|Houkago Saikoro Kurabu
Клятий Курйозний Кубик↑シーキューブ|C³ - CubexCursedxCurious|C3|C Cube|C^3
Книга друзів Нацуме (1 сезон)↑Natsume Yuujinchou|Natsume's Book of Friends|Natsume Yujincho, Natsume Yujin-cho|Natsume's Book of Friends|Natsume Yuujinchou
Книга друзів Нацуме (2 сезон)↑Zoku Natsume Yuujinchou|Natsume's Book of Friends Season 2|Natsume Yuujinchou Two, Natsume Yuujinchou 2, Natsume Yujincho 2|Natsume's Book of Friends Season 2|Zoku Natsume Yuujinchou
Книга друзів Нацуме (3 сезон)↑Natsume Yuujinchou San|Natsume's Book of Friends Season 3|Natsume Yuujinchou Three, Natsume Yuujinchou 3, Natsume Yujincho 3|Natsume's Book of Friends Season 3|Natsume Yuujinchou San
Книга друзів Нацуме (4 сезон)↑Natsume Yuujinchou Shi|Natsume's Book of Friends Season 4|Natsume Yuujinchou Four, Natsume Yuujinchou 4, Natsume Yujincho 4|Natsume's Book of Friends Season 4|Natsume Yuujinchou Shi
Книга друзів Нацуме (5 сезон)↑Natsume Yuujinchou Go|Natsume's Book of Friends Season 5|Natsume Yuujinchou Season 5, Natsume's Book of Friends Five|Natsume's Book of Friends Season 5|Natsume Yuujinchou Go
Книга друзів Нацуме (6 cезон)↑Natsume Yuujinchou Roku|Natsume's Book of Friends Season 6|Natsume Yuujinchou Season 6, Natsume's Book of Friends Six|Natsume's Book of Friends Season 6|Natsume Yuujinchou Roku
Книга друзів Нацуме (ОВА)↑Natsume Yuujinchou: Itsuka Yuki no Hi ni|Natsume’s Book of Friends: On a Certain Snowy Day|Natsume Yuujinchou OVA, Natsume Yujincho OVA, Natsume's Book of Friends OVA, Natsume on One Snowy Day|Natsume’s Book of Friends: On a Certain Snowy Day|Natsume Yuujinchou: Itsuka Yuki no Hi ni
Книга магії для початківців↑Zero kara Hajimeru Mahou no Sho|Grimoire of Zero|Grimoire of Zero|Zero kara Hajimeru Mahou no Sho
Книжкова принцеса / Принцеса Бібліофілка↑Mushikaburi-hime|Bibliophile Princess|Princess of the Bibliophile|Bibliophile Princess|Mushikaburi-hime
Кнур Багряний|Порко Россо↑Kurenai no Buta|Porco Rosso|The Scarlet Pig|Porco Rosso|Kurenai no Buta
Кнур Багряний|Порко Россо↑Kurenai no Buta|Porco Rosso|The Scarlet Pig|Porco Rosso|Kurenai no Buta
Кобилички: Доленосне Дербі 2↑Uma Musume: Pretty Derby Season 2|Uma Musume: Pretty Derby Season 2|Umamusume: Pretty Derby Season 2|Uma Musume: Pretty Derby Season 2
Кобилички: Доленосне дербі↑ウマ娘 プリティーダービー|Umamusume: Pretty Derby
Кобилички: Йонкома↑うまよん|Umayon|Uma Yon
Кобилички: Обіцянка БНВ↑ウマ娘 プリティーダービー BNWの誓い|Uma Musume: Pretty Derby - BNW no Chikai|Uma Musume: Pretty Derby Specials
Ковабон↑こわぼん|Kowabon
Ковбой Бібоп↑カウボーイビバップ|Cowboy Bebop
Ковбой Бібоп. Двері до раю↑カウボーイビバップ 天国の扉|Cowboy Bebop: The Movie|Cowboy Bebop: Knockin' on Heaven's Door
Ковбой Бібоп: Двері до раю↑カウボーイビバップ 天国の扉|Cowboy Bebop: The Movie|Cowboy Bebop: Knockin' on Heaven's Door
Ковчег Ⅸ, Дев'ятий ковчег↑ARK|Ark
Код Люгера 1951↑ルガーコード 1951|Luger Code 1951
Код Усвідомлення - Принцеса Буття↑Code:Realize - Sousei no Himegimi|Code:Realize ~Guardian of Rebirth~|Code:Realize ~Guardian of Rebirth~|Code:Realize - Sousei no Himegimi
Код Ґіас: Повстання Лелуша. Фільм 1 - Сходження↑Code Geass: Hangyaku no Lelouch I - Koudou|Code Geass: Lelouch of the Rebellion I - Initiation|Code Geass: Lelouch of the Rebellion - Awakening|Code Geass: Lelouch of the Rebellion I - Initiation|Code Geass: Hangyaku no Lelouch I - Koudou
Код Ґіас: Повстання Лелуша. Фільм 1 - Сходження↑Code Geass: Hangyaku no Lelouch I - Koudou|Code Geass: Lelouch of the Rebellion I - Initiation|Code Geass: Lelouch of the Rebellion - Awakening|Code Geass: Lelouch of the Rebellion I - Initiation|Code Geass: Hangyaku no Lelouch I - Koudou
Код Ґіас: Повстання Лелуша. Фільм 2 - Бунт↑Code Geass: Hangyaku no Lelouch II - Handou|Code Geass: Lelouch of the Rebellion II - Transgression|Code Geass: Lelouch of the Rebellion - Rebellion|Code Geass: Lelouch of the Rebellion II - Transgression|Code Geass: Hangyaku no Lelouch II - Handou
Код Ґіас: Повстання Лелуша. Фільм 2 - Бунт↑Code Geass: Hangyaku no Lelouch II - Handou|Code Geass: Lelouch of the Rebellion II - Transgression|Code Geass: Lelouch of the Rebellion - Rebellion|Code Geass: Lelouch of the Rebellion II - Transgression|Code Geass: Hangyaku no Lelouch II - Handou
Код Ґіасc: Повстання Лелуша 2↑Code Geass: Hangyaku no Lelouch R2|Code Geass: Lelouch of the Rebellion R2|Code Geass: Hangyaku no Lelouch 2nd Season, Code Geass: Hangyaku no Lelouch Second Season|Code Geass: Lelouch of the Rebellion R2|Code Geass: Hangyaku no Lelouch R2
Код Ґіасс: Повстання Лелуша / Бунтівний Лелуш↑Code Geass: Hangyaku no Lelouch|Code Geass: Lelouch of the Rebellion|Code Geass: Lelouch of the Rebellion|Code Geass: Hangyaku no Lelouch
Код: Руйнівник↑CØDE:BREAKER|Code:Breaker|Code Breaker
Код: Руйнівник ОВА↑CØDE:BREAKER|Code:Breaker OVA|Code Breaker OVA|Code:Breaker: code:extra 1|2|3 & Plus 1|Code:Breaker: code:100 & extra HANAMI & Plus 2|Code:Breaker: code:4koma Special Theater
Кожній тобі, яку я кохав↑Boku ga Aishita Subete no Kimi e|To Every You I've Loved Before|To All of You That I Loved|To Every You I've Loved Before|Boku ga Aishita Subete no Kimi e
Козоріг↑カプリコン|Capricorn
Коколорс↑COCOLORS（コカラス）|Cocolors
Коколорс↑COCOLORS（コカラス）|Cocolors
Коколорс↑COCOLORS（コカラス）|Cocolors
Кокпіт↑ザ・コクピット|The Cockpit|The Cockpit: Kamikaze Stories|Seisouken Kiryuu|Slipstream|Onsoku Raigekitai|Sonic Boom Squadron|Tetsu no Ryuukihei|Knight of the Iron Dragon
Колекція Джюнджі Іто↑Itou Junji: Collection|Junji Ito Collection|Junji Ito Collection|Itou Junji: Collection
Коли Аюму зробить свій крок?↑Soredemo Ayumu wa Yosetekuru|When Will Ayumu Make His Move?|Even so, Ayumu draws closer to the endgame, Even So, Ayumu Approaches, Soreayu|When Will Ayumu Make His Move?|Soredemo Ayumu wa Yosetekuru
Коли прийде час, я стану тобою↑Yagate Kimi ni Naru|Bloom Into You|YagaKimi, Eventually, I Will Become You|Bloom Into You|Yagate Kimi ni Naru
Коли я переродився слизом (2 сезон , 1 частина)↑Tensei shitara Slime Datta Ken 2nd Season|That Time I Got Reincarnated as a Slime Season 2|Tensura 2|That Time I Got Reincarnated as a Slime Season 2|Tensei shitara Slime Datta Ken 2nd Season
Коли я переродився слизом (3 сезон)↑Tensei shitara Slime Datta Ken 3rd Season|That Time I Got Reincarnated as a Slime Season 3|Tensura 3|That Time I Got Reincarnated as a Slime Season 3|Tensei shitara Slime Datta Ken 3rd Season
Коли я переродився слизом (ОВА)↑Tensei shitara Slime Datta Ken OVA|That Time I Got Reincarnated as a Slime OAD|TenSura OVA, That Time I Got Reincarnated as a Slime OVA, Tensei shitara Slime Datta Ken Gaiden, That Time I Got Reincarnated as a Slime Extra|That Time I Got Reincarnated as a Slime OAD|Tensei shitara Slime Datta Ken OVA
Коли я переродився слизом (сезон 2, частина 2)↑Tensei shitara Slime Datta Ken 2nd Season Part 2|That Time I Got Reincarnated as a Slime Season 2 Part 2|Tensura 2|That Time I Got Reincarnated as a Slime Season 2 Part 2|Tensei shitara Slime Datta Ken 2nd Season Part 2
Коли я переродився слизом / Про моє переродження в слиз↑Tensei shitara Slime Datta Ken|That Time I Got Reincarnated as a Slime|TenSura|That Time I Got Reincarnated as a Slime|Tensei shitara Slime Datta Ken
Коли я переродився слизом: Зв'язок Червоного Лотоса↑劇場版 転生したらスライムだった件 紅蓮の絆編|That Time I Got Reincarnated as a Slime: The Movie - Scarlet Bond|TenSura|That Time I Got Reincarnated as a Slime Movie
Коли я переродився слизом: Зв'язок Червоного Лотоса↑劇場版 転生したらスライムだった件 紅蓮の絆編|That Time I Got Reincarnated as a Slime: The Movie - Scarlet Bond|TenSura|That Time I Got Reincarnated as a Slime Movie|That Time I Got Reincarnated as a Slime the Movie: Scarlet Bond
Коли я переродився слизом: Щоденник слизу↑Tensura Nikki: Tensei shitara Slime Datta Ken|The Slime Diaries|The Slime Diaries|Tensura Nikki: Tensei shitara Slime Datta Ken
Колишній герой вигнанець живе як хоче↑Dekisokonai to Yobareta Motoeiyuu wa Jikka kara Tsuihou sareta node Sukikatte ni Ikiru Koto ni Shita|The Banished Former Hero Lives as He Pleases|The Banished Former Hero Lives as He Pleases|Dekisokonai to Yobareta Motoeiyuu wa Jikka kara Tsuihou sareta node Sukikatte ni Ikiru Koto ni Shita
Команда зоряного корабля↑スターシップ・オペレーターズ|Starship Operators
Команда мрії↑あひるの空|Ahiru no Sora
Комедія↑スウェットパンチ|Sweat Punch|Deep Imagination|Dan Petory Kyoushu no Yuutsu|Professor Dan Petry's Blues|End of the World|Kigeki|Comedy|Higan|Beyond|Garakuta no Machi|Junk Town
Комедія↑スウェットパンチ|Sweat Punch|Deep Imagination|Dan Petory Kyoushu no Yuutsu|Professor Dan Petry's Blues|End of the World|Kigeki|Comedy|Higan|Beyond|Garakuta no Machi|Junk Town
Комета Люцифер↑コメット・ルシファー|Comet Lucifer
Коморі-сан, не може відмовити!↑小森さんは断れない！|Komori-san Can't Decline!
Компанія Санти↑サンタ・カンパニー|Santa Company
Комітет зізнань в коханні↑Zutto Mae kara Suki deshita. Kokuhaku Jikkou Iinkai|I've Always Liked You|HoneyWorks: I've Liked You Since Long Ago, I've liked you for a long time.: Confession Committee, I've had feelings for you since a long time ago.: Executive Confession Committee|I've Always Liked You|Zutto Mae kara Suki deshita. Kokuhaku Jikkou Iinkai
Комічна психосоматика↑アニメで分かる心療内科|Comical Psychosomatic Medicine|Anime de Wakaru Shinryou Naika
Контратака поліціянтки↑Hakozume: Kouban Joshi no Gyakushuu|Police in a Pod|Police in a Pod|Hakozume: Kouban Joshi no Gyakushuu
Концерт Нобунаґи↑信長協奏曲〈コンツェルト〉|Nobunaga Concerto|Nobunaga Concierto|Nobunaga Kyousoukyoku
Конюшина↑CLOVER|Clover
Коппеліон↑コッペリオン|Coppelion
Кордон Шангрі-Ла↑Shangri-La Frontier: Kusoge Hunter, Kamige ni Idoman to su|Shangri-La Frontier|Shangri-La Frontier: Crappy Game Hunter Challenges God-Tier Game, Shanfro|Shangri-La Frontier|Shangri-La Frontier: Kusoge Hunter, Kamige ni Idoman to su
Королева демонів і Герой↑Maoyuu Maou Yuusha|Maoyu|Maoyu Maou Yusha|Maoyu|Maoyuu Maou Yuusha
Королева зі скальпелем↑Gekai Elise|Doctor Elise: The Royal Lady with the Lamp|Oegwauisa Elise, 외과의사 엘리제, Surgeon Elise, Doctor Elise: Queen with a Scalpel|Doctor Elise: The Royal Lady with the Lamp|Gekai Elise
Король Кільця↑Kekkon Yubiwa Monogatari|Tales of Wedding Rings|Tales of Wedding Rings|Kekkon Yubiwa Monogatari
Король Тернів↑いばらの王|King of Thorn|Ibara no Oh
Король Тернів↑いばらの王|King of Thorn|Ibara no Oh
Король Тернів↑Ibara no Ou|King of Thorn|Ibara no Oh|King of Thorn|Ibara no Ou
Король Шаман↑SHAMAN KING|Shaman King (2021)
Король печери: граф Монте-Крісто↑Gankutsuou|Gankutsuou: The Count of Monte Cristo|The King of the Cavern|Gankutsuou: The Count of Monte Cristo|Gankutsuou
Король шаманів / Король-шаман↑SHAMAN KING|Shaman King (2021)
Король шаманів: Квіти↑SHAMAN KING FLOWERS|Shaman King: Flowers
Королівства руїн↑Hametsu no Oukoku|The Kingdoms of Ruin|The Kingdoms of Ruin|Hametsu no Oukoku
Королівство↑キングダム|Kingdom
Королівство (2 сезон)↑Kingdom 2nd Season|Kingdom: Season 2|Kingdom Hisho Hen, Kingdom: Dai 2 Series|Kingdom: Season 2|Kingdom 2nd Season
Королівство (Сезон 3)↑Kingdom 3rd Season|Kingdom: Season 3|Kingdom: Season 3|Kingdom 3rd Season
Королівство 5↑Kingdom 5th Season|Kingdom: Season 5|Kingdom: Season 5|Kingdom 5th Season
Короткий метр↑火要鎮|Combustible|Short Peace
Космо Денді↑スペース☆ダンディ|Space Dandy
Космічна мандрівниця Кітті↑宇宙キャンパー/チッチ|Space Camper Chicchi
Космічний лінкор Ямато 2199: Зоряний ковчег↑宇宙戦艦ヤマト2199 星巡る方舟|Space Battleship Yamato 2199: Odyssey of the Celestial Ark|Uchuu Senkan Yamato 2199: Hoshi-Meguru Hakobune
Космічний пірат капітан Харлок↑キャプテンハーロック|Space Pirate Captain Harlock|Harlock Space Pirate
Космічний пірат капітан Харлок↑キャプテンハーロック|Space Pirate Captain Harlock|Harlock Space Pirate
Космічний пірат капітан Харлок↑キャプテンハーロック|Space Pirate Captain Harlock|Harlock Space Pirate
Космічні брати↑宇宙兄弟|Space Brothers|Uchuu Kyodai
Косуке та Рікімару: Конпейський дракон↑小助さま力丸さま-コンペイ島の竜-|Kosuke-sama Rikimaru-sama: Konpeitou no Ryuu|Kosukesama Rikimarusama: Konpeito no Ryu|Kosuke and Rikimaru: Dragon of Konpei Island
Котоура↑琴浦さん|The Troubled Life of Miss Kotoura|Kotoura-san
Котячий рай↑ネコぱら|Nekopara|Neko Para
Котячі будні↑にゃんこデイズ|Nyanko Days
Котячі примхи↑にゃんこい！|Nyan Koi!|Nyankoi
Котячі історії↑くるねこ|Kuruneko|Kuru Neko
Кохання наче відчуття після дощу↑恋は雨上がりのように|After the Rain|Koi wa Amaagari no You ni|Love is Like after the Rain|KoiAme
Кошик фруктів↑フルーツバスケット|Fruits Basket|Furuba
Кошик фруктів (2019) (1 сезон)↑フルーツバスケット|Fruits Basket 1st Season|Furuba|Fruits Basket (Zenpen)
Кошик фруктів (Сезон 2)↑フルーツバスケット 2nd season|Fruits Basket 2nd Season|Fruits Basket (2019) 2nd Season|Furuba|Fruits Basket (Kouhen)
Кошик фруктів. Фінал (3 сезон)↑フルーツバスケット The Final|Fruits Basket: The Final Season|Fruits Basket 3rd Season|Fruits Basket (2019) 3rd Season|Furuba
Крамничка солодощів (2 сезон)↑だがしかし2|Dagashi Kashi 2|Dagashikashi 2
Краплі спогадів|Ще вчора↑おもひでぽろぽろ|Only Yesterday|Omohide Poro Poro|Omoide Poro-poro|Memories Like Falling Rain Drops|Memories Like Falling Teardrops|Memories of Teardrops|Memories of Yesterday
Краплі спогадів|Ще вчора↑おもひでぽろぽろ|Only Yesterday|Omohide Poro Poro|Omoide Poro-poro|Memories Like Falling Rain Drops|Memories Like Falling Teardrops|Memories of Teardrops|Memories of Yesterday
Краплі спогадів|Ще вчора|Краплі спогадів / Ще вчора↑おもひでぽろぽろ|Only Yesterday|Omohide Poro Poro|Omoide Poro-poro|Memories Like Falling Rain Drops|Memories Like Falling Teardrops|Memories of Teardrops|Memories of Yesterday|Only Yesterday / Omohide Poro Poro
Красуня-воїн Сейлор Мун Кришталева↑美少女戦士セーラームーン Crystal|Pretty Guardian Sailor Moon Crystal|Pretty Soldier Sailor Moon (2014)|Sailor Moon Remake|Bishoujo Senshi Sailor Moon (2014)|Sailor Moon Crystal
Країна чудес смертників↑デッドマン・ワンダーランド|Deadman Wonderland|DEADMAN WONDERLAND
Кривавий Шкет↑ブラッドラッド|Blood Lad
Криза серед драконів! / Надокучливий Дракон!↑ドラゴンクライシス!|Dragon Crisis!
Крила порятунку↑よみがえる空 -Rescue Wings-|Yomigaeru Sora: Rescue Wings
Кришталеве небо вчорашнього дня↑昨日青空（动画样片）|Crystal Sky of Yesterday|Zuo Ri Qing Kong Pilot
Кришталеве небо вчорашнього дня↑昨日青空（动画样片）|Crystal Sky of Yesterday|Zuo Ri Qing Kong Pilot
Кришталеві небеса минулого↑昨日青空|Crystal Sky of Yesterday|Zuo Ri Qing Kong
Кров Трійці↑トリニティ・ブラッド|Trinity Blood
Кров+↑ブラッドプラス|Blood+|Blood Plus
Кров-С↑ブラッドシー|Blood-C
Кров-С: Останній темний↑劇場版 ブラッドシー ザ ラスト ダーク|Blood-C: The Last Dark|Blood-C Movie|Gekijouban Blood-C
Кров: Останній Вампір↑BLOOD THE LAST VAMPIRE (ブラッド ザ ラスト ヴァンパイア)|Blood: The Last Vampire
Кров: Останній вампір↑BLOOD THE LAST VAMPIRE (ブラッド ザ ラスト ヴァンパイア)|Blood: The Last Vampire
Кров: Останній вампір↑BLOOD THE LAST VAMPIRE (ブラッド ザ ラスト ヴァンパイア)|Blood: The Last Vampire
Крутий учитель Онідзука: Роки юності↑湘南純愛組!|Young GTO|Shounan Junai Gumi|Shounan Jun'ai-gumi!|Shonan Junai-gumi!|Pure Love Gang of Shounan
Крізь сльози я прикидаюсь кішкою↑泣きたい私は猫をかぶる|A Whisker Away|Nakineko
КсамД: Втрачені спогади↑亡念のザムド|Xam'd: Lost Memories|Bonen no Xamdou|Bonen no Zamudo|Bounen no Zamudo|Bounen no Zamned
Кулінарні поєдинки Соми↑食戟のソーマ|Food Wars! Shokugeki no Soma|Shokugeki no Soma|Food Wars: Shokugeki no Soma
Куродзука↑黒塚|Kurozuka|Black Tomb
Курчатко ОВА↑ひよ恋|Hiyokoi
Кібер-місто Едо 808↑CYBER CITY OEDO 808 (サイバーシティ オーエド ハチマルハチ)|Cyber City
Кігті звіра↑ケモノヅメ|Kemonozume|The Beast Claw
Кізнайвер↑キズナイーバー|Kiznaiver
Кірара↑KIRARA|Kirara
Кішечка із Сакурасо, Дівчатко-звірятко із Сакура-со↑さくら荘のペットな彼女|The Pet Girl of Sakurasou|Sakurasou no Pet na Kanojo
Кішки-зброярки↑ガンスミス キャッツ|Gunsmith Cats
Лабіринт сновидінь↑Manie-Manie 迷宮物語|Neo Tokyo|Manie Manie The Labyrinth Tales|Labyrinth Labyrinthos|Hashiru Otoko|The Order to Stop Construction|Construction Cancellation Order|Running Man|Meikyu Monogatari
Лазурний стрілець: Ґанвольт↑蒼き雷霆〈アームドブルー〉 ガンヴォルト|Armed Blue Gunvolt|Azure Striker Gunvolt
Лазуровий шлях↑アズールレーン THE ANIMATION|Azur Lane the Animation|Azur Lane
Лампа дідуся↑おぢいさんのランプ|Ojiisan no Lamp|Wakate Animator Ikusei Project|2010 Young Animator Training Project|Anime Mirai 2010|Ojii-san no Lamp|Grandfather's Lamp|Project A
Лампа дідуся↑おぢいさんのランプ|Ojiisan no Lamp|Wakate Animator Ikusei Project|2010 Young Animator Training Project|Anime Mirai 2010|Ojii-san no Lamp|Grandfather's Lamp|Project A
Лампа дідуся↑おぢいさんのランプ|Ojiisan no Lamp|Wakate Animator Ikusei Project|2010 Young Animator Training Project|Anime Mirai 2010|Ojii-san no Lamp|Grandfather's Lamp|Project A
Ласкаво просимо на Космічне Шоу↑宇宙ショーへようこそ|Welcome to THE SPACE SHOW|Uchu Show e Youkoso
Ласкаво просимо на Космічне Шоу↑宇宙ショーへようこそ|Welcome to THE SPACE SHOW|Uchu Show e Youkoso|Welcome to the Space Show
Ласкаво просимо на Космічне шоу↑宇宙ショーへようこそ|Welcome to THE SPACE SHOW|Uchu Show e Youkoso
Ласт Екзаїл / Останній вигнанець↑LAST EXILE（ラストエグザイル）|Last Exile
Легенда про Білосніжку↑白雪姫の伝説|The Legend of Snow White|Shirayukihime|Legend of Princess Snow White|Shirayuki-hime no Densetsu
Легенда про Вісім Псів Сходу↑八犬伝 -東方八犬異聞-|Hakkenden -Eight Dogs of the East-|Hakkenden: Touhou Hakken Ibun
Легенда про Койдзумі↑ムダヅモ無き改革|Mudazumo Naki Kaikaku: The Legend of Koizumi|Mudadumo Naki Kaikaku|Mudatsumo|Reform without Wasted Draws
Легенда про ангела↑エンジェル伝説|Angel Densetsu|Angel Legend
Легенда про героїв галактики: Я завоюю море зірок↑銀河英雄伝説: わが征くは星の大海|Legend of the Galactic Heroes: My Conquest is the Sea of Stars|LoGH: My Conquest Is the Sea of Stars|Legend of the Galactic Heroes MOVIE (1988)
Легенда про героїв галактики: Я завоюю море зірок↑銀河英雄伝説: わが征くは星の大海|Legend of the Galactic Heroes: My Conquest is the Sea of Stars|LoGH: My Conquest Is the Sea of Stars|Legend of the Galactic Heroes MOVIE (1988)|Legend of the Galactic Heroes: My Conquest Is the Sea of Stars
Легенда про героїв: Сліди холодної сталі - Північна війна↑The Legend of Heroes 閃の軌跡 Northern War|The Legend of Heroes: Trails of Cold Steel - Northern War|Eiyuu Densetsu: Sen no Kiseki
Легенда про легендарних героїв↑伝説の勇者の伝説|The Legend of the Legendary Heroes|DenYuDen|DenYuuDen|Densetsu no Yusha no Densetsu|LOLH
Легенди Зестірії: Перетин↑テイルズ オブ ゼスティリア ザ クロス|Tales of Zestiria the X
Легка музика! Фільм!!!↑映画 けいおん！|K-ON! The Movie|Eiga K-On!|Keion Movie
Летюча трапеція↑空中ブランコ|Welcome to Irabu's Office|Kuchu Buranko|Trapeze|Flying Trapeze
Летючий корабель-привид↑空飛ぶゆうれい船|Flying Phantom Ship|Sora Tobu Yuurei Sen|The Flying Ghost Ship|Sora Tobu Yureisen
Лист до Момо↑ももへの手紙|A Letter to Momo|Momo e no Tegami
Лист до Момо↑ももへの手紙|A Letter to Momo|Momo e no Tegami
Лист до Момо↑ももへの手紙|A Letter to Momo|Momo e no Tegami
Лист із країни собак↑ある日 犬の国から手紙が来て|Aru Hi Inu no Kuni kara Tegami ga Kite|One Day A Letter Arrives from the Dog Kingdom
Лихе Місто|Місто чудовиськ|Лихе Місто / Місто чудовиськ↑妖獣都市|Wicked City|Demon Beast City|Supernatural Beast City|Yoju Toshi
Лиходій Бін↑BEAN BANDIT|Bean Bandit
Лицар-вампір↑ヴァンパイア騎士〈ナイト〉|Vampire Knight|Vampire Kishi
Лицарі Сідонії (2 сезон) / Лицарі Сідонії. Битва за дев'яту планету↑シドニアの騎士 第九惑星戦役|Knights of Sidonia: Battle for Planet Nine|Knights of Sidonia: War of the Ninth Planet|Sidonia no Kishi: Dai-kyuu Wakusei Seneki
Лицарі Ґуларту: темрява, що прокинулася від сну↑グラール騎士団 Evoked the Beginning Black|Goulart Knights: Evoked the Beginning Black|Goulart Kishidan: Evoked the Beginning Black
Ловець Карт Сакура: Прозорі Карти / Картоловка Сакура: Чисті Карти↑カードキャプターさくら クリアカード編|Cardcaptor Sakura: Clear Card|Cardcaptor Sakura: Clear Card-hen
Лоґ Горизонт / Лоґ Горайзон↑ログ・ホライズン|Log Horizon
Любий у Франксі / Милий у Франксі↑ダーリン・イン・ザ・フランキス|DARLING in the FRANXX
Любий, я вдома↑ただいま、おかえり|Tadaima, Okaeri
Любов наживо! Проект: Шкільний ідол↑君のこころは輝いてるかい？|Kimi no Kokoro wa Kagayaiteru kai?|Love Live! Sunshine!!|Love Live! School Idol Project
Любов наживо! Проект: Шкільний ідол (сезон 2)↑ラブライブ! School idol project 2期|Love Live! School Idol Project 2
Любовна сцена!!↑LOVE STAGE!!|Love Stage!!
Любовний щоденник Отоме Надешіко↑乙女なでしこ恋手帖|Otome Nadeshiko Koi Techou|Otome Nadeshiko Love Diary
Любовні історії Тачібанакану↑立花館To Lieあんぐる|Love To-LIE-Angle|Tachibanakan To Lie Angle
Любі серцю↑SUPER LOVERS（スーパーラヴァーズ）|Super Lovers
Любі серцю (2 сезон)↑SUPER LOVERS（スーパーラヴァーズ） 2|Super Lovers 2|Super Lovers Second Season
Люди Ікс↑エックスメン|X-Men
Люди-вовки↑人狼 JIN-ROH|Jin-Roh: The Wolf Brigade|Jinrou
Люди-вовки↑人狼 JIN-ROH|Jin-Roh: The Wolf Brigade|Jinrou|Jin-Roh
Люди-вовки↑人狼 JIN-ROH|Jin-Roh: The Wolf Brigade|Jinrou
Людина-бензопила↑チェンソーマン|Chainsaw Man
Людина-диявол: Сирена↑Devilman: Yochou Sirene-hen|Devilman: The Demon Bird|Devilman: The Demon Bird|Devilman: Yochou Sirene-hen
Люпен ІІІ: Замок Каліостро↑ルパン三世 カリオストロの城|Lupin III: The Castle of Cagliostro|Rupan Sansei|Lupin the Third: The Castle of Cagliostro / Rupan Sansei. Kariosutoro no Shir
Люпен ІІІ: Замок Каліостро↑Lupin III: Cagliostro no Shiro|Lupin III: The Castle of Cagliostro|Rupan Sansei|Lupin III: The Castle of Cagliostro|Lupin III: Cagliostro no Shiro
Люпен ІІІ: Замок Каліостро↑Lupin III: Cagliostro no Shiro|Lupin III: The Castle of Cagliostro|Rupan Sansei|Lupin III: The Castle of Cagliostro|Lupin III: Cagliostro no Shiro
Люпен: Початок↑LUPIN ZERO|Lupin Zero
Лють Багамута - Незаймана Душа↑神撃のバハムート VIRGIN SOUL|Rage of Bahamut: Virgin Soul
Лють Багамута: Початок↑Shingeki no Bahamut: Genesis|Rage of Bahamut: Genesis|Rage of Bahamut: Genesis|Shingeki no Bahamut: Genesis
Люцифер і бісквітний молот↑Hoshi no Samidare|Lucifer and the Biscuit Hammer|Lucifer and the Biscuit Hammer|Hoshi no Samidare
Лялечка↑Pupa (ピューパ)|Pupa
Ліза та Блакитна Пташка↑リズと青い鳥|Liz and the Blue Bird|Gekijouban Hibike! Euphonium: Mizore to Nozomi no Monogatari|Hibike! Euphonium: The Story of Mizore and Nozomi|Hibike! Euphonium Movie: Mizore to Nozomi no Monogatari
Ліза та Блакитна Пташка↑リズと青い鳥|Liz and the Blue Bird|Gekijouban Hibike! Euphonium: Mizore to Nozomi no Monogatari|Hibike! Euphonium: The Story of Mizore and Nozomi|Hibike! Euphonium Movie: Mizore to Nozomi no Monogatari
Ліза та Блакитна Пташка↑Liz to Aoi Tori|Liz and the Blue Bird|Gekijouban Hibike! Euphonium: Mizore to Nozomi no Monogatari, Hibike! Euphonium: The Story of Mizore and Nozomi, Hibike! Euphonium Movie: Mizore to Nozomi no Monogatari|Liz and the Blue Bird|Liz to Aoi Tori
Лікар для монстродівчат↑Monster Musume no Oishasan|Monster Girl Doctor|The doctor for monster girls|Monster Girl Doctor|Monster Musume no Oishasan
Лікоріс Рекоіл↑リコリス・リコイル|Lycoris Recoil|LycoReco
Лінія дияволів↑デビルズライン|Devils' Line
Ліс Мійорі↑Miyori no Mori|Miyori's Forest|Miyori's Forest|Miyori no Mori
Ліс Мійорі↑Miyori no Mori|Miyori's Forest|Miyori's Forest|Miyori no Mori
Ліс Мійорі↑Miyori no Mori|Miyori's Forest|Miyori's Forest|Miyori no Mori
Ліс, де мерехтять світлячки / До лісу світлячків↑Hotarubi no Mori e|Into the Forest of Fireflies' Light|The Light of a Firefly Forest|Into the Forest of Fireflies' Light|Hotarubi no Mori e
Лісовий Рояль↑ピアノの森 The Perfect World of Kai|The Piano Forest|The Perfect World of Kai|Forest of Piano
Лісовий Рояль↑Piano no Mori|The Piano Forest|The Perfect World of Kai, Forest of Piano|The Piano Forest|Piano no Mori
Лісовий рояль (ТБ)↑Piano no Mori (TV)|Forest of Piano|Piano Forest, The Perfect World of Kai|Forest of Piano|Piano no Mori (TV)
Літаючий будинок↑Tondera House no Daibouken|The Flying House|Time Kyoshitsu: Tondera House no Daiboken, Time Classroom, Adventures of Tondera [Flying] House|The Flying House|Tondera House no Daibouken
Літературне дівча / Буквоїжка (фільм)↑"Bungaku Shoujo" Movie|"Bungaku Shoujo" Movie|Book Girl, Literature Girl|"Bungaku Shoujo" Movie
Літературне дівча, Буквоїжка↑“文学少女”今日のおやつ 〜はつ恋〜|"Bungaku Shoujo" Kyou no Oyatsu: Hatsukoi|Bungaku Shoujo OVA|Book Girl OVA|Literature Girl OVA
Літературне дівча: Спогади↑“文学少女”メモワール|"Bungaku Shoujo" Memoire|Book Girl: Memoire|Literature Girl: Memoire
Літературні генії Бродячі Пси (1 сезон)↑Bungou Stray Dogs|Bungo Stray Dogs|Literary Stray Dogs, BSD|Bungo Stray Dogs|Bungou Stray Dogs
Літературні генії Бродячі Пси (2 сезон)↑Bungou Stray Dogs 2nd Season|Bungo Stray Dogs 2|Bungo Stray Dogs 2|Bungou Stray Dogs 2nd Season
Літературні генії Бродячі Пси (4 сезон)↑Bungou Stray Dogs 4th Season|Bungo Stray Dogs 4|Bungo Stray Dogs 4|Bungou Stray Dogs 4th Season
Літературні генії Бродячі Пси (Сезон 5)↑Bungou Stray Dogs 5th Season|Bungo Stray Dogs 5|Bungo Stray Dogs 5|Bungou Stray Dogs 5th Season
Літературні генії Бродячі Пси (сезон 3)↑Bungou Stray Dogs 3rd Season|Bungo Stray Dogs 3|Bungo Stray Dogs 3|Bungou Stray Dogs 3rd Season
Літературні генії Бродячі Пси. Мертве Яблуко↑文豪ストレイドッグス DEAD APPLE|Bungo Stray Dogs: Dead Apple
Літературні генії Бродячі Пси. Мертве Яблуко↑文豪ストレイドッグス DEAD APPLE|Bungo Stray Dogs: Dead Apple
Літературні генії Бродячі Пси. Мертве Яблуко↑文豪ストレイドッグス DEAD APPLE|Bungo Stray Dogs: Dead Apple
Літня пора / Відгомін літньої пори↑サマータイムレンダ|Summer Time Rendering
Літнє Кафе та його Богині↑女神のカフェテラス|The Café Terrace and Its Goddesses|Goddess Café Terrace
Літні Дні з Ку↑河童のクゥと夏休み|Summer Days with Coo|Kappa no Coo to Natsuyasumi
Літні Дні з Ку↑河童のクゥと夏休み|Summer Days with Coo|Kappa no Coo to Natsuyasumi
Літні Дні з Ку↑河童のクゥと夏休み|Summer Days with Coo|Kappa no Coo to Natsuyasumi
Літні війни↑サマーウォーズ|Summer Wars
Літній привид↑サマーゴースト|Summer Ghost|Project Common
Літній привид↑サマーゴースト|Summer Ghost|Project Common
Літній привид / Привид Літа↑サマーゴースト|Summer Ghost|Project Common
Літопис війни Лодосса↑Lodoss-tou Senki|Record of Lodoss War|Record of Lodoss War OVA|Record of Lodoss War|Lodoss-tou Senki
МАПС↑マップス|Maps|MAPS (1994)
Мабороші / Фабрика ілюзій Аліси і Терези↑Alice to Therese no Maboroshi Koujou|Maboroshi|Alice and Therese's Illusion Factory, The Illusion Factory of Alice and Therese|Maboroshi|Alice to Therese no Maboroshi Koujou
Маг на повну ставку↑全职法师|Full-Time Magister|Quan Zhi Fa Shi
Маг на повну ставку 2↑全职法师Ⅱ|Full-Time Magister 2nd Season|Quanzhi Fashi 2nd Season|Quan Zhi Fa Shi 2|Full-Time Magister 2
Маг, що повернувся, — особливий↑Kikansha no Mahou wa Tokubetsu desu|A Returner's Magic Should Be Special|Gwihwanja-ui Mabeop-eun Teukbyeol-haeya Hamnida, 귀환자의 마법은 특별해야 합니다|A Returner's Magic Should Be Special|Kikansha no Mahou wa Tokubetsu desu
Маг-читер в іншому світі↑異世界チート魔術師〈マジシャン〉|Isekai Cheat Magician|Isekai Cheat Majutsushi
Магічна Битва (2 сезон)↑呪術廻戦 懐玉・玉折／渋谷事変|Jujutsu Kaisen Season 2|Jujutsu Kaisen: Kaigyoku Gyokusetsu|Jujutsu Kaisen: Shibuya Jihen|Sorcery Fight|JJK
Магічна Битва: 0↑劇場版 呪術廻戦 0|Jujutsu Kaisen 0|Gekijouban Jujutsu Kaisen 0|JJK 0
Магічна Битва: 0↑劇場版 呪術廻戦 0|Jujutsu Kaisen 0|Gekijouban Jujutsu Kaisen 0|JJK 0
Магічна Битва: 0↑劇場版 呪術廻戦 0|Jujutsu Kaisen 0|Gekijouban Jujutsu Kaisen 0|JJK 0
Магічна битва↑Jujutsu Kaisen|Jujutsu Kaisen|Sorcery Fight, JJK|Jujutsu Kaisen
Магічна дівчина: Магічні руйнатори↑魔法少女マジカルデストロイヤーズ|Magical Destroyers|Magical Girl Magical Destroyers|MagiDes
Магічна революція переродженої принцеси та геніальної панянки↑Tensei Oujo to Tensai Reijou no Mahou Kakumei|The Magical Revolution of the Reincarnated Princess and the Genius Young Lady|Tenten Kakumei, MagiRevo|The Magical Revolution of the Reincarnated Princess and the Genius Young Lady|Tensei Oujo to Tensai Reijou no Mahou Kakumei
Магічно-торгівельний квартал Абенобаші↑アベノ橋魔法☆商店街|Magical☆Shopping Arcade Abenobashi|Abenobashi Magic Shopping District|Abenobashi Mahoh Shotengai|Magical Shopping Street Abenobashi|Magical Shopping Arcade Abenobashi
Магічні війни↑Mahou Sensou|Magical Warfare|Mahosen|Magical Warfare|Mahou Sensou
Магічні нотатки: Чарівниця Мадока Магіка↑Magia Record: Mahou Shoujo Madoka☆Magica Gaiden|Magia Record: Puella Magi Madoka Magica Side Story|Puella Magi Madoka Magica Side Story: Magia Record|Magia Record: Puella Magi Madoka Magica Side Story|Magia Record: Mahou Shoujo Madoka☆Magica Gaiden
Магія Стелли↑Stella no Mahou|Magic of Stella|Magic of Stella|Stella no Mahou
Майстер демонічного клинка з академії Екскалібур↑Seiken Gakuin no Makentsukai|The Demon Sword Master of Excalibur Academy|Magic Sword Master of Holy Sword School|The Demon Sword Master of Excalibur Academy|Seiken Gakuin no Makentsukai
Майстер демонічного культу↑魔道祖师|The Founder of Diabolism Season 1|Modao Zushi|Grandmaster of Demonic Cultivation|The Founder of Diabolism|Mo Dao Zu Shi: Qianchen Pian|魔道祖师 前尘篇|Madou Soshi
Майстер демонічного культу 2↑Mo Dao Zu Shi: Xian Yun Pian|The Founder of Diabolism Season 2|Grandmaster of Demonic Cultivation 2, The Founder of Diabolism 2, Mo Dao Zu Shi 2nd Season, The Founder of Diabolism: The Reborn|The Founder of Diabolism Season 2|Mo Dao Zu Shi: Xian Yun Pian
Майстер демонічного культу 3↑Mo Dao Zu Shi: Wanjie Pian|The Founder of Diabolism Season 3|Grandmaster of Demonic Cultivation 3, The Founder of Diabolism 3, Mo Dao Zu Shi 3rd Season, Mo Dao Zu Shi Final Arc|The Founder of Diabolism Season 3|Mo Dao Zu Shi: Wanjie Pian
Майстер демонічного культу чібі↑Mo Dao Zu Shi Q|The Founder of Diabolism Q|The Founder of Diabolism Q|Mo Dao Zu Shi Q
Майстер меча онлайн: Порядковий ранг / Сворд Арт Онлайн: Ординал Скейл↑劇場版 ソードアート・オンライン -オーディナル・スケール-|Sword Art Online the Movie: Ordinal Scale|Gekijouban Sword Art Online|Sword Art Online: The Movie Ordinal Scale / Gekijouban Sword Art Online: Ordinal Scale
Майстер на всі руки Сайто в іншому світі↑Benriya Saitou-san, Isekai ni Iku|Handyman Saitou in Another World|Handyman Saitou in Another World|Benriya Saitou-san, Isekai ni Iku
Майстерня Ески та Лоґі: Алхіміки Сутінкового неба↑Escha & Logy no Atelier: Tasogare no Sora no Renkinjutsushi|Atelier Escha & Logy: Alchemists of the Dusk Sky|Atelier Escha & Logy: Alchemists of the Dusk Sky|Escha & Logy no Atelier: Tasogare no Sora no Renkinjutsushi
Майстри бар'єрів↑結界師|Kekkaishi|Barrier Master
Макрос Плюс↑マクロスプラス|Macross Plus
Макросс - Чи пам'ятаєш ти кохання?↑超時空要塞マクロス -愛・おぼえていますか-|Macross: Do You Remember Love?|Clash of the Bionoids|Gekijouban Choujikuu Yousai Macross: Ai|Oboete Imasu ka|Macross in Clash Of The Bionoids|Super Dimensional Fortress Macross The Movie: Do You Remember Love?|Choujikuu Yousai Macross: Ai Oboete Imasuka
Макросс Зеро↑マクロス ゼロ|Macross Zero
Макросс Фронтір↑Macross F|Macross Frontier|Macross Frontier|Macross F
Макіавеалізм озброєних дівчат↑Busou Shoujo Machiavellianism|Armed Girl's Machiavellism|Armed Girl's Machiavellism|Busou Shoujo Machiavellianism
Маленький зоопарк Сюзі↑Suzy's Zoo だいすき！ウィッツィー|Suzy's Zoo: Daisuki! Witzy|Suzy Dongwuyuan
Маленькі серії: Чюнібьо теж хочуть кохати!↑Chuunibyou demo Koi ga Shitai! Lite|Love, Chunibyo & Other Delusions!: Chuni-Shorts|Regardless of My Adolescent Delusions of Grandeur, I Want a Date! Lite, Chu-2 Byo demo Koi ga Shitai! Lite, Love, Chunibyo & Other Delusions Lite|Love, Chunibyo & Other Delusions!: Chuni-Shorts|Chuunibyou demo Koi ga Shitai! Lite
Манаріянські друзі↑マナリアフレンズ|Mysteria Friends|Rage of Bahamut: Manaria Friends|Shingeki no Bahamut: Manaria Friends
Мандрівний замок↑ハウルの動く城|Howl's Moving Castle
Мандрівний замок Хаула↑ハウルの動く城|Howl's Moving Castle
Мандрівний замок Хаула / Замок-мандрівник↑ハウルの動く城|Howl's Moving Castle
Мандрівники↑プラネテス|Planetes|ΠΛΑΝΗΤΕΣ
Мандрівниця з Полум'я↑Fire Tripper|Fire Tripper|Rumic World 1|Fire Tripper
Манускрипт ніндзя / Повість про Джюбея, ніндзя вітру↑Juubee Ninpuuchou|Ninja Scroll|Wind Ninja Chronicles, Juubei Ninpucho|Ninja Scroll|Juubee Ninpuuchou
Манускрипт ніндзя / Повість про Джюбея, ніндзя вітру↑Juubee Ninpuuchou|Ninja Scroll|Wind Ninja Chronicles, Juubei Ninpucho|Ninja Scroll|Juubee Ninpuuchou
Манускрипт ніндзя: Нова глава↑獣兵衛忍風帖「龍宝玉篇」|Ninja Scroll: The Series|Juubee Ninpuuchou: Ryuuhougyoku Hen|Jubei Ninpucho - Ryuhougyokuhen|Jubei Ninpucho: Ryuhogyoku-Hen|Wind Ninja Chronicles [Dragon Stone Chapter]|Ninja Scroll - The Series
Манґа та дівчата!↑まんがーる!|Mangirl!
Манґака та його асистентки↑Mangaka-san to Assistant-san to The Animation|The Comic Artist and His Assistants|Mangaka-san to Assistant-san to, ManAshi|The Comic Artist and His Assistants|Mangaka-san to Assistant-san to The Animation
Маргінальна служба / Рубіжна служба↑THE MARGINAL SERVICE|The Marginal Service
Марієзалежність↑まりあ†ほりっく|Maria†Holic|Maria+Holic|MariaHolic
Машл 2: Претендентський Іспит на Божественного Провидця↑Mashle: Shinkakusha Kouho Senbatsu Shiken-hen|Mashle: Magic and Muscles - The Divine Visionary Candidate Exam Arc|Mashle 2nd Season|Mashle: Magic and Muscles - The Divine Visionary Candidate Exam Arc|Mashle: Shinkakusha Kouho Senbatsu Shiken-hen
Машл: магія і м'язи↑Mashle|Mashle: Magic and Muscles|Mashle: Magic and Muscles|Mashle
Маєток тіней↑シャドーハウス|Shadows House
Маєток тіней (2 сезон)↑シャドーハウス 2nd Season|Shadows House 2nd Season
Маґі: Королівство Магії↑マギ The kingdom of magic|Magi: The Kingdom of Magic|Magi: The Labyrinth of Magic 2|Magi Season 2
Маґі: Лабіринт магії↑マギ The labyrinth of magic|Magi: The Labyrinth of Magic|Magi Season 1
Маґі: Пригоди Сіндбада↑マギ シンドバッドの冒険|Magi: Sinbad no Bouken|Magi: Adventure of Sinbad OVA
Мегазона 23↑メガゾーン23|Megazone 23|Megazone 23 Part II|Megazone 23 Part III|Robotech: The Untold Story (U.S.)
Мед і конюшина↑Hachimitsu to Clover|Honey and Clover|HachiKuro, Honey & Clover|Honey and Clover|Hachimitsu to Clover
Медлакс↑マドラックス|Madlax
Медуза не може плавати вночі↑Yoru no Kurage wa Oyogenai|Jellyfish Can't Swim in the Night|Yorukura|Jellyfish Can't Swim in the Night|Yoru no Kurage wa Oyogenai
Межа пустоти. Благословення майбутнього↑Kara no Kyoukai Movie: Mirai Fukuin|The Garden of Sinners: Future Gospel|Kara no Kyoukai: the Garden of sinners/recalled out summer, the Garden of sinners -recalled out summer-|The Garden of Sinners: Future Gospel|Kara no Kyoukai Movie: Mirai Fukuin
Межа пустоти. Благословення майбутнього (додаткова глава)↑劇場版 空の境界 未来福音 extra chorus|The Garden of Sinners: Future Gospel - Extra Chorus|Kara no Kyoukai: the Garden of sinners/recalled out summer - extra chorus|the Garden of sinners -recalled out summer- extra chorus
Межа пустоти: Сад грішників - Благословення майбутнього↑劇場版 空の境界 未来福音|The Garden of Sinners: Future Gospel|Kara no Kyoukai: the Garden of sinners/recalled out summer|the Garden of sinners -recalled out summer-
Межа пустоти: Сад грішників - Благословення майбутнього↑劇場版 空の境界 未来福音|The Garden of Sinners: Future Gospel|Kara no Kyoukai: the Garden of sinners/recalled out summer|the Garden of sinners -recalled out summer-
Межа пустоти: Сад грішників - Фільм 1: З висоти польоту птахи↑劇場版 空の境界 the Garden of sinners 第一章『俯瞰風景』|The Garden of Sinners Chapter 1: Overlooking View|Kara no Kyoukai: The Garden of Sinners Movie 1|Borderline of Emptiness: Overlooking View|The Garden of Sinners: Thanatos
Межа пустоти: Сад грішників - Фільм 1: З висоти польоту птахи↑劇場版 空の境界 the Garden of sinners 第一章『俯瞰風景』|The Garden of Sinners Chapter 1: Overlooking View|Kara no Kyoukai: The Garden of Sinners Movie 1|Borderline of Emptiness: Overlooking View|The Garden of Sinners: Thanatos|The Garden of Sinners: Overlooking View
Межа пустоти: Сад грішників - Фільм 2: Вбивствознавство, ч. 1↑劇場版 空の境界 the Garden of sinners 第二章『殺人考察（前）』|The Garden of Sinners Chapter 2: A Study in Murder - Part 1|Kara no Kyoukai: The Garden of Sinners Movie 2|Borderline of Emptiness: Murder Speculation|The Garden of Sinners: A Study in Murder|The Garden of Sinners: …and nothing heart
Межа пустоти: Сад грішників - Фільм 2: Вбивствознавство, ч. 1↑Kara no Kyoukai Movie 2: Satsujin Kousatsu (Zen)|The Garden of Sinners Chapter 2: A Study in Murder - Part 1|Kara no Kyoukai: The Garden of Sinners Movie 2, Borderline of Emptiness: Murder Speculation, The Garden of Sinners: A Study in Murder, The Garden of Sinners: …and nothing heart|The Garden of Sinners Chapter 2: A Study in Murder - Part 1|Kara no Kyoukai Movie 2: Satsujin Kousatsu (Zen)
Межа пустоти: Сад грішників - Фільм 3: Біль, що залишився↑劇場版 空の境界 the Garden of sinners 第三章『痛覚残留』|The Garden of Sinners Chapter 3: Remaining Sense of Pain|Kara no Kyoukai: The Garden of Sinners Movie 3|Borderline of Emptiness: Remaining Sense of Pain|The Garden of Sinners: ever cry|never life
Межа пустоти: Сад грішників - Фільм 3: Біль, що залишився↑劇場版 空の境界 the Garden of sinners 第三章『痛覚残留』|The Garden of Sinners Chapter 3: Remaining Sense of Pain|Kara no Kyoukai: The Garden of Sinners Movie 3|Borderline of Emptiness: Remaining Sense of Pain|The Garden of Sinners: ever cry|never life|The Garden of Sinners: Remaining Sense of Pain
Межа пустоти: Сад грішників - Фільм 4: Храм пустоти↑劇場版 空の境界 the Garden of sinners 第四章『伽藍の洞』|The Garden of Sinners Chapter 4: The Hollow Shrine|Kara no Kyoukai: The Garden of Sinners Movie 4|Borderline of Emptiness: The Hollow Shrine|The Garden of Sinners: garan-no-dou
Межа пустоти: Сад грішників - Фільм 4: Храм пустоти↑劇場版 空の境界 the Garden of sinners 第四章『伽藍の洞』|The Garden of Sinners Chapter 4: The Hollow Shrine|Kara no Kyoukai: The Garden of Sinners Movie 4|Borderline of Emptiness: The Hollow Shrine|The Garden of Sinners: garan-no-dou|The Garden of Sinners: The Hollow Shrine
Межа пустоти: Сад грішників - Фільм 5: Спіраль парадоксу↑劇場版 空の境界 the Garden of sinners 第五章『矛盾螺旋』|The Garden of Sinners Chapter 5: Paradox Spiral|Kara no Kyoukai: The Garden of Sinners Movie 5|Borderline of Emptiness: Paradox Spiral|The Garden of Sinners: Paradox Paradigm
Межа пустоти: Сад грішників - Фільм 5: Спіраль парадоксу↑劇場版 空の境界 the Garden of sinners 第五章『矛盾螺旋』|The Garden of Sinners Chapter 5: Paradox Spiral|Kara no Kyoukai: The Garden of Sinners Movie 5|Borderline of Emptiness: Paradox Spiral|The Garden of Sinners: Paradox Paradigm|The Garden of Sinners: Paradox Spiral
Межа пустоти: Сад грішників - Фільм 6: Нотатки забуття↑劇場版 空の境界 the Garden of sinners 第六章『忘却録音』|The Garden of Sinners Chapter 6: Oblivion Recording|Kara no Kyoukai: The Garden of Sinners Movie 6|Borderline of Emptiness: Oblivion Recording|The Garden of Sinners: Fairy Tale
Межа пустоти: Сад грішників - Фільм 6: Нотатки забуття↑劇場版 空の境界 the Garden of sinners 第六章『忘却録音』|The Garden of Sinners Chapter 6: Oblivion Recording|Kara no Kyoukai: The Garden of Sinners Movie 6|Borderline of Emptiness: Oblivion Recording|The Garden of Sinners: Fairy Tale|The Garden of Sinners: Oblivion Recording
Межа пустоти: Сад грішників - Фільм 7: Вбивствознавство, ч. 2↑Kara no Kyoukai Movie 7: Satsujin Kousatsu (Go)|The Garden of Sinners Chapter 7: A Study in Murder - Part 2|Kara no Kyoukai: The Garden of Sinners Movie 7, Borderline of Emptiness: Murder Speculation (Part 2), The Garden of Sinners: ...not nothing heart|The Garden of Sinners Chapter 7: A Study in Murder - Part 2|Kara no Kyoukai Movie 7: Satsujin Kousatsu (Go)
Межа пустоти: Сад грішників - Фільм 7: Вбивствознавство, ч. 2↑Kara no Kyoukai Movie 7: Satsujin Kousatsu (Go)|The Garden of Sinners Chapter 7: A Study in Murder - Part 2|Kara no Kyoukai: The Garden of Sinners Movie 7, Borderline of Emptiness: Murder Speculation (Part 2), The Garden of Sinners: ...not nothing heart|The Garden of Sinners Chapter 7: A Study in Murder - Part 2|Kara no Kyoukai Movie 7: Satsujin Kousatsu (Go)
Межа пустоти: Сад грішників - Фільм 8: Епілог↑劇場版 空の境界 the Garden of sinners 終章|The Garden of Sinners Chapter 8: Epilogue|Kara no Kyoukai: Epilogue|The Garden of Sinners Epilogue|The Garden of Sinners: the Garden of Sinners|The Garden of Sinners: Epilogue
Межа пустоти: Сад грішників - Фільм 8: Епілог↑劇場版 空の境界 the Garden of sinners 終章|The Garden of Sinners Chapter 8: Epilogue|Kara no Kyoukai: Epilogue|The Garden of Sinners Epilogue|The Garden of Sinners: the Garden of Sinners
Межа пустоти: Сад грішників. Епілог↑Kara no Kyoukai Movie 8: Shuushou|The Garden of Sinners Chapter 8: Epilogue|Kara no Kyoukai: Epilogue, The Garden of Sinners Epilogue, The Garden of Sinners: the Garden of Sinners|The Garden of Sinners Chapter 8: Epilogue|Kara no Kyoukai Movie 8: Shuushou
Межа пустоти: Сад грішників. Фільм другий. Вбивствознавство. Частина перша↑Kara no Kyoukai Movie 2: Satsujin Kousatsu (Zen)|The Garden of Sinners Chapter 2: A Study in Murder - Part 1|Kara no Kyoukai: The Garden of Sinners Movie 2, Borderline of Emptiness: Murder Speculation, The Garden of Sinners: A Study in Murder, The Garden of Sinners: …and nothing heart|The Garden of Sinners Chapter 2: A Study in Murder - Part 1|Kara no Kyoukai Movie 2: Satsujin Kousatsu (Zen)
Межа пустоти: Сад грішників. Фільм п'ятий - Спіраль Парадоксу↑Kara no Kyoukai Movie 5: Mujun Rasen|The Garden of Sinners Chapter 5: Paradox Spiral|Kara no Kyoukai: The Garden of Sinners Movie 5, Borderline of Emptiness: Paradox Spiral, The Garden of Sinners: Paradox Paradigm|The Garden of Sinners Chapter 5: Paradox Spiral|Kara no Kyoukai Movie 5: Mujun Rasen
Межа пустоти: Сад грішників. Фільм сьомий - Вбивствознавство↑Kara no Kyoukai Movie 7: Satsujin Kousatsu (Go)|The Garden of Sinners Chapter 7: A Study in Murder - Part 2|Kara no Kyoukai: The Garden of Sinners Movie 7, Borderline of Emptiness: Murder Speculation (Part 2), The Garden of Sinners: ...not nothing heart|The Garden of Sinners Chapter 7: A Study in Murder - Part 2|Kara no Kyoukai Movie 7: Satsujin Kousatsu (Go)
Межа пустоти: Сад грішників. Фільм третій - Біль, що залишився↑Kara no Kyoukai Movie 3: Tsuukaku Zanryuu|The Garden of Sinners Chapter 3: Remaining Sense of Pain|Kara no Kyoukai: The Garden of Sinners Movie 3, Borderline of Emptiness: Remaining Sense of Pain, The Garden of Sinners: ever cry, never life|The Garden of Sinners Chapter 3: Remaining Sense of Pain|Kara no Kyoukai Movie 3: Tsuukaku Zanryuu
Межа пустоти: Сад грішників. Фільм четвертий - Храм пустоти↑Kara no Kyoukai Movie 4: Garan no Dou|The Garden of Sinners Chapter 4: The Hollow Shrine|Kara no Kyoukai: The Garden of Sinners Movie 4, Borderline of Emptiness: The Hollow Shrine, The Garden of Sinners: garan-no-dou|The Garden of Sinners Chapter 4: The Hollow Shrine|Kara no Kyoukai Movie 4: Garan no Dou
Межа пустоти: Сад грішників. Фільм шостий - Нотатки Забуття↑Kara no Kyoukai Movie 6: Boukyaku Rokuon|The Garden of Sinners Chapter 6: Oblivion Recording|Kara no Kyoukai: The Garden of Sinners Movie 6, Borderline of Emptiness: Oblivion Recording, The Garden of Sinners: Fairy Tale|The Garden of Sinners Chapter 6: Oblivion Recording|Kara no Kyoukai Movie 6: Boukyaku Rokuon
Межа пустоти: Фільм перший - З висоти польоту птахи↑Kara no Kyoukai Movie 1: Fukan Fuukei|The Garden of Sinners Chapter 1: Overlooking View|Kara no Kyoukai: The Garden of Sinners Movie 1, Borderline of Emptiness: Overlooking View, The Garden of Sinners: Thanatos|The Garden of Sinners Chapter 1: Overlooking View|Kara no Kyoukai Movie 1: Fukan Fuukei
Мекард↑터닝메카드|Turning Mecard
Меланхолія Харухі Судзумії↑涼宮ハルヒの憂鬱|The Melancholy of Haruhi Suzumiya|Suzumiya Haruhi no Yuuutsu
Мелодія Акі↑アキの奏で|Aki no Kanade|Wakate Animator Ikusei Project|2015 Young Animator Training Project|Anime Mirai 2015
Мемуари Ванітаса↑ヴァニタスの手記|The Case Study of Vanitas|Vanitas no Shuki|Memoir of Vanitas|Vanitas no Carte
Мемуари Ванітаса (частина 2)↑Vanitas no Karte Part 2|The Case Study of Vanitas Part 2|Vanitas no Shuki 2nd Season, Memoir of Vanitas 2nd Season, Vanitas no Carte 2nd Season|The Case Study of Vanitas Part 2|Vanitas no Karte Part 2
Мене вдруге викликали в інший світ↑Isekai Shoukan wa Nidome desu|Summoned to Another World for a Second Time|Isenido|Summoned to Another World for a Second Time|Isekai Shoukan wa Nidome desu
Мені за тридцять вже минало, аж раптом з армії прогнали↑Kaiko sareta Ankoku Heishi (30-dai) no Slow na Second Life|Chillin' in My 30s after Getting Fired from the Demon King's Army|Chillin' in My 30s after Getting Fired from the Demon King's Army|Kaiko sareta Ankoku Heishi (30-dai) no Slow na Second Life
Мені не подобається біль, тому качатиму тільки захист↑Itai no wa Iya nanode Bougyoryoku ni Kyokufuri Shitai to Omoimasu.|BOFURI: I Don't Want to Get Hurt, so I'll Max Out My Defense.|I hate being in pain, so I think I'll make a full defense build., I Hate Getting Hurt, So I Put All My Skill Points Into Defense|BOFURI: I Don't Want to Get Hurt, so I'll Max Out My Defense.|Itai no wa Iya nanode Bougyoryoku ni Kyokufuri Shitai to Omoimasu.|BOFURI: I Don't Want to Get Hurt, so I'll Max Out My Defense
Мені не подобається біль, тому качатиму тільки захист. 2↑Itai no wa Iya nanode Bougyoryoku ni Kyokufuri Shitai to Omoimasu. 2|BOFURI: I Don't Want to Get Hurt, so I'll Max Out My Defense. Season 2|BOFURI: I Don't Want to Get Hurt, so I'll Max Out My Defense 2nd Season, I hate being in pain, so I think I'll make a full defense build 2, I Hate Getting Hurt, So I Put All My Skill Points Into Defense 2|BOFURI: I Don't Want to Get Hurt, so I'll Max Out My Defense. Season 2|Itai no wa Iya nanode Bougyoryoku ni Kyokufuri Shitai to Omoimasu. 2
Мені, який тебе кохав↑Kimi wo Aishita Hitori no Boku e|To Me, The One Who Loved You|To the Only Me Who Loved You|To Me, The One Who Loved You|Kimi wo Aishita Hitori no Boku e
Мердок Скрембл↑Mardock Scramble: The First Compression|Mardock Scramble: The First Compression|Mardock Scramble: Asshuku|Mardock Scramble: The First Compression
Мертве Листя↑デッド　リーブス|Dead Leaves
Мертвяцька Вечірка: Замордовані Душі↑コープスパーティー Tortured Souls -暴虐された魂の呪叫-|Corpse Party: Tortured Souls|Corpse Party: Tortured Souls - Bougyakusareta Tamashii no Jukyou
Мері та відьомська квітка↑Mary to Majo no Hana|Mary and the Witch's Flower|Mary and the Witch's Flower|Mary to Majo no Hana
Месник↑REVENGER (リベンジャー)|Revenger
Металева Руж↑メタリックルージュ|Metallic Rouge
Метрополіс↑METROPOLIS|Metropolis (2009)
Метушня!↑バッカーノ！|Baccano!
Механічна планета / Завідна Планета↑クロックワーク・プラネット|Clockwork Planet
Механічні руки↑Mecha-ude|Mechanical Arms|Mechanical Arms|Mecha-ude
Мецо-форте↑メゾフォルテ|Mezzo Forte
Меч Короля - Остання Фантазія XV↑KINGSGLAIVE FINAL FANTASY XV|Kingsglaive: Final Fantasy XV
Меч Чужинця↑Stranger: Mukou Hadan Pilot|Sword of the Stranger Pilot|Sword of the Stranger Pilot|Stranger: Mukou Hadan Pilot
Меґалобокс↑メガロボクス|Megalobox
Меґалобокс 2↑Nomad: Megalo Box 2|Megalobox 2: Nomad|Megalobox 2: Nomad|Nomad: Megalo Box 2
Ми досі не знаємо імені квіточки, яку бачили того дня↑Ano Hi Mita Hana no Namae wo Bokutachi wa Mada Shiranai.|Anohana: The Flower We Saw That Day|AnoHana, We Still Don't Know the Name of the Flower We Saw That Day|Anohana: The Flower We Saw That Day|Ano Hi Mita Hana no Namae wo Bokutachi wa Mada Shiranai.
Милий Дім Чі / Чі. Життя однієї киці↑チーズスイートホーム|Chi's Sweet Home|Chii's Sweet Home|Chiizu
Мисливець x Мисливець (1999)↑HUNTER×HUNTER（ハンター×ハンター）|Hunter x Hunter|HxH
Мисливець на вампірів Ді: Жага крові↑バンパイアハンターD|Vampire Hunter D: Bloodlust|Vampire Hunter D (2001)|Vampire Hunter D Movie
Мисливець на вампірів Ді: Жага крові↑バンパイアハンターD|Vampire Hunter D: Bloodlust|Vampire Hunter D (2001)|Vampire Hunter D Movie
Мисливець на вампірів Ді: Жага крові↑吸血鬼〈バンパイア〉ハンターD|Vampire Hunter D
Мисливець на вогонь↑Hikari no Ou|The Fire Hunter|The Fire Hunter|Hikari no Ou
Мисливець на вогонь (Сезон 2)↑Hikari no Ou 2nd Season|The Fire Hunter Season 2|The Fire Hunter Season 2|Hikari no Ou 2nd Season
Мисливець на відьму↑エル・カザド|El Cazador de la Bruja|El Cazador|The Witch Hunter
Мисливець х Мисливець↑Hunter x Hunter (2011)|Hunter x Hunter|HxH (2011)|Hunter x Hunter|Hunter x Hunter (2011)
Мисливець і мисливець: Примарний вигнанець↑劇場版 HUNTER×HUNTER 緋色の幻影（ファントム・ルージュ）|Hunter x Hunter: Phantom Rouge|Gekijouban Hunter x Hunter: Hiiro no Genei|HxH Movie
Мисливець і мисливець: Примарний вигнанець↑劇場版 HUNTER×HUNTER 緋色の幻影（ファントム・ルージュ）|Hunter x Hunter: Phantom Rouge|Gekijouban Hunter x Hunter: Hiiro no Genei|HxH Movie
Мисливець і мисливець: Примарний вигнанець↑劇場版 HUNTER×HUNTER 緋色の幻影（ファントム・ルージュ）|Hunter x Hunter: Phantom Rouge|Gekijouban Hunter x Hunter: Hiiro no Genei|HxH Movie
Мистецтво Меча Онлайн Прогресія - Скерцо глибокої ночі↑Sword Art Online: Progressive Movie - Kuraki Yuuyami no Scherzo|Sword Art Online the Movie: Progressive - Scherzo of Deep Night|Sword Art Online the Movie: Progressive - Scherzo of Deep Night|Sword Art Online: Progressive Movie - Kuraki Yuuyami no Scherzo
Мистецтво меча онлайн: Прогресія - Арія беззоряної ночі↑Sword Art Online: Progressive Movie - Hoshi Naki Yoru no Aria|Sword Art Online the Movie: Progressive - Aria of a Starless Night|SAO Progressive Movie, Aria in the Starless Night, Hoshinaki Yoru no Aria|Sword Art Online the Movie: Progressive - Aria of a Starless Night|Sword Art Online: Progressive Movie - Hoshi Naki Yoru no Aria
Мить за миттю↑刻刻|Kokkoku
Моб-Вар'ят 100 (1 сезон)↑モブサイコ100|Mob Psycho 100|Mob Psycho Hyaku|Mob Psycho One Hundred
Моб-Вар'ят 100 (2 сезон)↑モブサイコ100 II|Mob Psycho 100 II|Mob Psycho 100 2nd Season|Mob Psycho Hyaku|Mob Psycho One Hundred
Моб-Вар'ят 100 (3 сезон)↑モブサイコ100 III|Mob Psycho 100 III|Mob Psycho 100 3rd Season|Mob Psycho Hyaku|Mob Psycho One Hundred
Мобільна броня Ґандам 00↑Kidou Senshi Gundam 00|Mobile Suit Gundam 00|Gundam Double O|Mobile Suit Gundam 00|Kidou Senshi Gundam 00
Мобільна броня Ґандам 0080: Кишенькова війна↑機動戦士ガンダム 0080 ポケットの中の戦争|Mobile Suit Gundam 0080: War in the Pocket
Мобільна броня Ґандам. Грозовий Сектор. Бандитська квітка↑機動戦士ガンダム サンダーボルト BANDIT FLOWER|Mobile Suit Gundam Thunderbolt: Bandit Flower
Мобільна броня Ґандам. Грозовий Сектор. Бандитська квітка↑機動戦士ガンダム サンダーボルト BANDIT FLOWER|Mobile Suit Gundam Thunderbolt: Bandit Flower
Мобільна броня Ґандам. Грозовий Сектор. Бандитська квітка↑機動戦士ガンダム サンダーボルト BANDIT FLOWER|Mobile Suit Gundam Thunderbolt: Bandit Flower
Мобільна броня Ґандам. Грозовий Сектор. Грудневе небо↑機動戦士ガンダム サンダーボルト DECEMBER SKY|Mobile Suit Gundam Thunderbolt: December Sky
Мобільна броня Ґандам. Грозовий Сектор. Грудневе небо↑機動戦士ガンダム サンダーボルト DECEMBER SKY|Mobile Suit Gundam Thunderbolt: December Sky
Мобільна броня Ґандам. Острів Доана Кукуруза↑機動戦士ガンダム ククルス・ドアンの島|Mobile Suit Gundam: Cucuruz Doan's Island|G-Doan
Мобільна броня Ґандам. Острів Доана Кукуруза↑機動戦士ガンダム ククルス・ドアンの島|Mobile Suit Gundam: Cucuruz Doan's Island|G-Doan
Мобільна броня Ґандам. Острів Доана Кукуруза↑機動戦士ガンダム ククルス・ドアンの島|Mobile Suit Gundam: Cucuruz Doan's Island|G-Doan|Kidô senshi Gundam Cucuruz Doan no shima
Мобільна броня Ґандам. Покоління К.Е.73: Зоряний мрійник↑機動戦士ガンダムSEED C.E.73: Stargazer|Mobile Suit Gundam SEED C.E.73: Stargazer|Kidou Senshi Gundam SEED C.E. 73: Stargazer
Мобільна броня Ґандам. Покоління К.Е.73: Зоряний мрійник↑機動戦士ガンダムSEED C.E.73: Stargazer|Mobile Suit Gundam SEED C.E.73: Stargazer|Kidou Senshi Gundam SEED C.E. 73: Stargazer
Мобільна броня Ґандам. Початок↑機動戦士ガンダムTHE ORIGIN|Mobile Suit Gundam: The Origin
Мобільна броня Ґандам. Спалах Гетевея↑機動戦士ガンダム 閃光のハサウェイ|Mobile Suit Gundam: Hathaway
Мобільна броня Ґандам. Спалах Гетевея (частина 1)↑機動戦士ガンダム 閃光のハサウェイ|Mobile Suit Gundam: Hathaway
Мобільна броня Ґандам: 8й взвод↑機動戦士ガンダム 第08MS小隊|Mobile Suit Gundam: The 08th MS Team|Kidou Senshi Gundam: Dai 08 MS Shotai
Мобільна броня Ґандам: Відьма з Меркурію↑機動戦士ガンダム 水星の魔女|Mobile Suit Gundam: The Witch from Mercury|G-Witch
Мобільна броня Ґандам: Відьма з Меркурію. Пролог↑機動戦士ガンダム 水星の魔女 PROLOGUE|Mobile Suit Gundam: The Witch from Mercury - Prologue
Мобільна броня Ґандам: Відьма з Меркурія (сезон 2)↑Kidou Senshi Gundam: Suisei no Majo Season 2|Mobile Suit Gundam: The Witch from Mercury Season 2|Mobile Suit Gundam: The Witch from Mercury Season 2|Kidou Senshi Gundam: Suisei no Majo Season 2
Мобільна броня Ґандам: Доля покоління↑機動戦士ガンダムSEED DESTINY|Mobile Suit Gundam SEED Destiny|Kidou Senshi Gundam SEED DESTINY
Мобільна броня Ґандам: Зета↑機動戦士Ζガンダム|Mobile Suit Zeta Gundam|Kidou Senshi Z Gundam|Mobile Suit Z Gundam
Мобільна броня Ґандам: Покоління↑機動戦士ガンダムSEED|Mobile Suit Gundam SEED|Kidou Senshi Gundam SEED
Мобільний воїн Ґандам↑Kidou Senshi Gundam I|Mobile Suit Gundam I|Kidou Senshi Gundam I Gekijouban, Mobile Suit Gundam Movie 1|Mobile Suit Gundam I|Kidou Senshi Gundam I
Мобільний воїн Ґандам Фільм 2 : Солдати Смутку↑機動戦士ガンダムⅡ　哀・戦士編|Mobile Suit Gundam II: Soldiers of Sorrow|Mobile Suit Gundam Movie 2
Мобільний воїн Ґандам Фільм 2 : Солдати Смутку↑機動戦士ガンダムⅡ　哀・戦士編|Mobile Suit Gundam II: Soldiers of Sorrow|Mobile Suit Gundam Movie 2
Мобільний воїн Ґандам Фільм 2: Солдати Смутку↑機動戦士ガンダムⅡ　哀・戦士編|Mobile Suit Gundam II: Soldiers of Sorrow|Mobile Suit Gundam Movie 2
Мобільний воїн Ґандам Фільм 3 : Зіткнення у космосі↑機動戦士ガンダムⅢ　めぐりあい宇宙編|Mobile Suit Gundam III: Encounters in Space|Kidou Senshi Gundam III: Meguriai Uchuu Hen|Mobile Suit Gundam Movie 3
Мобільний воїн Ґандам Фільм 3 : Зіткнення у космосі↑機動戦士ガンダムⅢ　めぐりあい宇宙編|Mobile Suit Gundam III: Encounters in Space|Kidou Senshi Gundam III: Meguriai Uchuu Hen|Mobile Suit Gundam Movie 3
Мобільний воїн Ґандам Фільм 3 : Зіткнення у космосі↑機動戦士ガンダムⅢ　めぐりあい宇宙編|Mobile Suit Gundam III: Encounters in Space|Kidou Senshi Gundam III: Meguriai Uchuu Hen|Mobile Suit Gundam Movie 3
Мобільний воїн Ґандам: Фільм 1↑劇場版　機動戦士ガンダム I　特別編|Mobile Suit Gundam I|Kidou Senshi Gundam I Gekijouban|Mobile Suit Gundam Movie 1
Мова води↑Mizu no Kotoba|Aquatic Language|Aquatic Language|Mizu no Kotoba
Могила світлячків↑Hotaru no Haka|Grave of the Fireflies|Tombstone for Fireflies|Grave of the Fireflies|Hotaru no Haka
Могутня Берді↑Tetsuwan Birdy|Birdy the Mighty|Birdy the Mighty|Tetsuwan Birdy
Могутня Берді (ОВА-2)↑Tetsuwan Birdy Decode: The Cipher|Birdy the Mighty: Decode OVA|Tetsuwan Birdy Decode OVA, Birdy the Mighty Decode OVA|Birdy the Mighty: Decode OVA|Tetsuwan Birdy Decode: The Cipher
Молодо-зелено↑グリーングリーン|Green Green OVA|Green Green
Молодша Сестра — Все, Що Тобі Потрібно↑Imouto sae Ireba Ii.|A Sister's All You Need|It'd be Good if Only Little Sister Was Here|A Sister's All You Need|Imouto sae Ireba Ii.
Молоді Мазохісти!↑えむえむっ!|MM!|MM! Group|Emu Emu!
Молодість Блек Джека↑ヤング ブラック・ジャック|Young Black Jack
Момо: Маленька богиня смерті↑しにがみのバラッド。|Momo, Girl God of Death|Shinigami no Ballad.: Momo the Girl God of Death|Shinigami's Ballad
Момокурі↑ももくり|momokuri
Монкарт↑몬카트|MONKART|Monkart: Legend of Monster Kart
Монолог Маомао↑猫猫のひとりごと|Maomao no Hitorigoto
Монолог травниці↑Kusuriya no Hitorigoto|The Apothecary Diaries|The Pharmacist's Monologue, Drugstore Soliloquy|The Apothecary Diaries|Kusuriya no Hitorigoto
Мононоке↑モノノ怪|Mononoke
Монстр↑始石疯暴|Monster
Монстр який сидить поруч↑となりの怪物くん|My Little Monster|Tonari no Kaibutsukun|The Monster Next Door|My Neighbor Monster-kun
Монстри: 103 Милосердя Прокляття Дракона↑Monsters: Ippyaku Sanjou Hiryuu Jigoku|Monsters: 103 Mercies Dragon Damnation|Monsters: 103 Mercies Dragon Damnation|Monsters: Ippyaku Sanjou Hiryuu Jigoku
Монсуно↑Juusen Battle Monsuno|Monsuno: World Master|Beast Rotation Battle Monsuno, Monsuno: Combat Chaos|Monsuno: World Master|Juusen Battle Monsuno
Морфонізація↑BanG Dream! Morfonication
Морячки↑High School Fleet|High School Fleet|Haifuri|High School Fleet
Моторошний Кітаро↑Gegege no Kitarou (2018)|GeGeGe no Kitaro|Spooky Kitaro|GeGeGe no Kitaro|Gegege no Kitarou (2018)
Моя Історія Кохання з Ямадою 999 рівня↑Yamada-kun to Lv999 no Koi wo Suru|My Love Story with Yamada-kun at Lv999|Loving Yamada at Lv999|My Love Story with Yamada-kun at Lv999|Yamada-kun to Lv999 no Koi wo Suru
Моя Богиня : У кожного є крила↑ああっ女神さまっ　それぞれの翼|Ah! My Goddess: Flights of Fancy|Ah! My Goddess: Sorezore no Tsubasa
Моя академія героїв (1 сезон), Моя геройська академія (1 сезон)↑Boku no Hero Academia|My Hero Academia|My Hero Academia|Boku no Hero Academia
Моя академія героїв (2 сезон) / Моя геройська академія (2 сезон)↑Boku no Hero Academia 2nd Season|My Hero Academia Season 2|My Hero Academia Season 2|Boku no Hero Academia 2nd Season
Моя академія героїв (3 сезон), Моя геройська академія (3 сезон)↑Boku no Hero Academia 3rd Season|My Hero Academia Season 3|My Hero Academia Season 3|Boku no Hero Academia 3rd Season
Моя академія героїв (4 сезон) / Моя геройська академія (4 сезон)↑Boku no Hero Academia 4th Season|My Hero Academia Season 4|My Hero Academia Season 4|Boku no Hero Academia 4th Season
Моя академія героїв (5 сезон) / Моя геройська академія (5 сезон)↑Boku no Hero Academia 5th Season|My Hero Academia Season 5|My Hero Academia 5|My Hero Academia Season 5|Boku no Hero Academia 5th Season
Моя академія героїв (6 сезон) / Моя геройська академія (6 сезон)↑Boku no Hero Academia 6th Season|My Hero Academia Season 6|My Hero Academia 6|My Hero Academia Season 6|Boku no Hero Academia 6th Season
Моя академія героїв: Двоє героїв↑Boku no Hero Academia the Movie 1: Futari no Hero|My Hero Academia: Two Heroes|My Hero Academia the Movie: The Two Heroes|My Hero Academia: Two Heroes|Boku no Hero Academia the Movie 1: Futari no Hero
Моя академія героїв: Двоє героїв↑Boku no Hero Academia the Movie 1: Futari no Hero|My Hero Academia: Two Heroes|My Hero Academia the Movie: The Two Heroes|My Hero Academia: Two Heroes|Boku no Hero Academia the Movie 1: Futari no Hero
Моя академія героїв: Двоє героїв / Моя Геройська Академія: Два Герої↑Boku no Hero Academia the Movie 1: Futari no Hero|My Hero Academia: Two Heroes|My Hero Academia the Movie: The Two Heroes|My Hero Academia: Two Heroes|Boku no Hero Academia the Movie 1: Futari no Hero
Моя академія героїв: Місія світових героїв↑Boku no Hero Academia the Movie 3: World Heroes' Mission|My Hero Academia: World Heroes' Mission|My Hero Academia the Movie 3|My Hero Academia: World Heroes' Mission|Boku no Hero Academia the Movie 3: World Heroes' Mission
Моя академія героїв: Місія світових героїв↑Boku no Hero Academia the Movie 3: World Heroes' Mission|My Hero Academia: World Heroes' Mission|My Hero Academia the Movie 3|My Hero Academia: World Heroes' Mission|Boku no Hero Academia the Movie 3: World Heroes' Mission
Моя академія героїв: Місія світових героїв↑Boku no Hero Academia the Movie 3: World Heroes' Mission|My Hero Academia: World Heroes' Mission|My Hero Academia the Movie 3|My Hero Academia: World Heroes' Mission|Boku no Hero Academia the Movie 3: World Heroes' Mission
Моя академія героїв: Сходження героїв↑僕のヒーローアカデミア THE MOVIE　ヒーローズ：ライジング|My Hero Academia: Heroes Rising|My Hero Academia the Movie 2: Heroes:Rising
Моя академія героїв: Сходження героїв. Фільм 2↑僕のヒーローアカデミア THE MOVIE　ヒーローズ：ライジング|My Hero Academia: Heroes Rising|My Hero Academia the Movie 2: Heroes:Rising
Моя богиня! (1 сезон)↑Aa! Megami-sama! (TV)|Ah! My Goddess|Ah! My Goddess! (TV)|Ah! My Goddess|Aa! Megami-sama! (TV)
Моя дівчина невинна, але справжня розпусниця↑僕の彼女がマジメ過ぎるしょびっちな件|My Girlfriend is Shobitch|My Girlfriend is a Faithful Virgin Bitch|Boku no Kanojo ga Majimesugiru Shojo Bitch na Ken
Моя зведена сестра – моя колишня↑Mamahaha no Tsurego ga Motokano datta|My Stepmom's Daughter Is My Ex|My Stepsister is My Ex-Girlfriend, Tsurekano|My Stepmom's Daughter Is My Ex|Mamahaha no Tsurego ga Motokano datta
Моя здібність миттєвої смерті настільки сильна, що ніхто в іншому світі не має шансу проти мене!↑Sokushi Cheat ga Saikyou sugite, Isekai no Yatsura ga Marude Aite ni Naranai n desu ga.|My Instant Death Ability is So Overpowered, No One in This Other World Stands a Chance Against Me!|The other world doesn't stand a chance against the power of instant death|My Instant Death Ability is So Overpowered, No One in This Other World Stands a Chance Against Me!|Sokushi Cheat ga Saikyou sugite, Isekai no Yatsura ga Marude Aite ni Naranai n desu ga.
Моя крихітна наставниця↑Uchi no Kaisha no Chiisai Senpai no Hanashi|My Tiny Senpai|My Company's Small Senpai, Story of a Small Senior in My Company|My Tiny Senpai|Uchi no Kaisha no Chiisai Senpai no Hanashi
Моя перша Ґяру↑はじめてのギャル|My First Girlfriend is a Gal|Hajimete no Gyaru
Моя романтична комедія не зовсім те, на що я очікував. Фінал (3 сезон)↑Yahari Ore no Seishun Love Comedy wa Machigatteiru. Kan|My Teen Romantic Comedy SNAFU Climax!|Yahari Ore no Seishun Love Comedy wa Machigatteiru. 3rd Season, My Teen Romantic Comedy SNAFU 3, Oregairu 3, My youth romantic comedy is wrong as I expected 3|My Teen Romantic Comedy SNAFU Climax!|Yahari Ore no Seishun Love Comedy wa Machigatteiru. Kan
Моя сусідка - вампірка↑Tonari no Kyuuketsuki-san|Ms. Vampire who lives in my neighborhood.|Ms. Vampire who lives in my neighborhood.|Tonari no Kyuuketsuki-san|Ms. Vampire who lives in my neighborhood
Моя унікальна здібність робить мене OP навіть на 1-му рівні↑Lv1魔王とワンルーム勇者|Level 1 Demon Lord and One Room Hero
Моє переродження в меч / Переродження мечем↑Tensei shitara Ken deshita|Reincarnated as a Sword|I became the sword by transmigrating, TenKen|Reincarnated as a Sword|Tensei shitara Ken deshita
Мої сусіди Ямада|Наші сусіди - родина Ямада↑ホーホケキョ となりの山田くん|My Neighbors the Yamadas|Houhokekyo Tonari no Yamada-kun|Hoohokekyo Tonari no Yamada-kun
Мої сусіди Ямада|Наші сусіди - родина Ямада|Мої сусіди Ямада / Наші сусіди - родина Ямада↑ホーホケキョ となりの山田くん|My Neighbors the Yamadas|Houhokekyo Tonari no Yamada-kun|Hoohokekyo Tonari no Yamada-kun|My Neighbors the Yamadas / Tonari no Yamada-kun
Мої сусіди Ямада|Наші сусіди - родина Ямада↑Tonari no Yamada-kun|My Neighbors the Yamadas|Houhokekyo Tonari no Yamada-kun, Hoohokekyo Tonari no Yamada-kun|My Neighbors the Yamadas|Tonari no Yamada-kun
Мрійливий хлопець - реаліст↑Yumemiru Danshi wa Genjitsushugisha|The Dreaming Boy is a Realist|The Dreaming Boy is a Realist|Yumemiru Danshi wa Genjitsushugisha
Мрії Андроїда↑Palme no Ki|A Tree of Palme|Arbre de Palmem|A Tree of Palme|Palme no Ki
Музичка↑Ongaku|On-Gaku: Our Sound|On-Gaku: Our Sound|Ongaku
Музичний стратег Конгмінг↑Paripi Koumei|Ya Boy Kongming!|Party People Koumei|Ya Boy Kongming!|Paripi Koumei
Мушіші↑蟲師|Mushi-Shi
Мушіші. Наступна глава↑蟲師 続章|Mushi-shi: Next Passage Part 1|Mushi-shi Zoku Shou|Mushishi: The Next Chapter
Мушіші. Тінь, що поглинає сонце↑蟲師 特別篇「日蝕む翳」|Mushi-shi: The Shadow that Devours the Sun|Mushi-shi Tokubetsu-hen: Hihamu Kage|Mushishi Special: Hihamukage
Мушіші: Тінь, що поглинає сонце↑蟲師 特別篇「日蝕む翳」|Mushi-shi: The Shadow that Devours the Sun|Mushi-shi Tokubetsu-hen: Hihamu Kage|Mushishi Special: Hihamukage
Мушіші: Тінь, що поглинає сонце↑蟲師 特別篇「日蝕む翳」|Mushi-shi: The Shadow that Devours the Sun|Mushi-shi Tokubetsu-hen: Hihamu Kage|Mushishi Special: Hihamukage|Mushishi: The Shadow That Devours the Sun
Міжвидові Оглядачі / Міжвидові Рецензенти↑異種族レビュアーズ|Interspecies Reviewers
Мій братик вже не братик!↑Oniichan wa Oshimai!|Onimai: I'm Now Your Sister!|Onimai, Onii-chan is Done For|Onimai: I'm Now Your Sister!|Oniichan wa Oshimai!
Мій господар не має хвоста↑Uchi no Shishou wa Shippo ga Nai|My Master Has No Tail|My Master Has No Tail|Uchi no Shishou wa Shippo ga Nai
Мій дивакуватий друг↑Jijou wo Shiranai Tenkousei ga Guigui Kuru.|My Clueless First Friend|The Clueless Transfer Student Is Assertive|My Clueless First Friend|Jijou wo Shiranai Tenkousei ga Guigui Kuru.
Мій домашній герой↑マイホームヒーロー|My Home Hero
Мій миленький тиран↑Akkun to Kanojo|My Sweet Tyrant|Akkun and His Girlfriend|My Sweet Tyrant|Akkun to Kanojo
Мій новий шеф дурник↑Atarashii Joushi wa Do Tennen|My New Boss Is Goofy|My New Boss Is Goofy|Atarashii Joushi wa Do Tennen
Мій семпай дратує↑Senpai ga Uzai Kouhai no Hanashi|My Senpai is Annoying|My Senpai is Annoying|Senpai ga Uzai Kouhai no Hanashi
Мій сусід Секі-кун↑Tonari no Seki-kun|Tonari no Seki-kun: The Master of Killing Time|My Neighbor Seki|Tonari no Seki-kun: The Master of Killing Time|Tonari no Seki-kun
Мій сусід Тоторо↑となりのトトロ|My Neighbor Totoro|My Neighbour Totoro
Мій сусід Тоторо↑Tonari no Totoro|My Neighbor Totoro|My Neighbour Totoro|My Neighbor Totoro|Tonari no Totoro
Мій улюблений робот↑こはるびより|Indian Summer|Koharubiyori
Мій щасливий шлюб↑Watashi no Shiawase na Kekkon|My Happy Marriage|My Blissful Marriage, Watakon|My Happy Marriage|Watashi no Shiawase na Kekkon
Міні-дракон↑Mini Dragon|Miss Kobayashi's Dragon Maid S Short Animation Series|Minidora|Miss Kobayashi's Dragon Maid S Short Animation Series|Mini Dragon
Мірай з майбутнього↑Mirai no Mirai|Mirai|Mirai of the Future|Mirai|Mirai no Mirai
Мірай з майбутнього↑Mirai no Mirai|Mirai|Mirai of the Future|Mirai|Mirai no Mirai
Міс Монохром↑ミス・モノクローム -The Animation-|Miss Monochrome The Animation
Містика, дівчата і таємничі зникнення↑Kaii to Otome to Kamikakushi|Mysterious Disappearances|Mysteries, Maidens, And Mysterious Disappearances, Totokami|Mysterious Disappearances|Kaii to Otome to Kamikakushi
Містична бібліотека Данталіан↑ダンタリアンの書架|The Mystic Archives of Dantalian|Bibliotheca Mystica de Dantalian|Dantalian's Bookshelf
Місто Демонів: Шінджюку↑魔界都市〈新宿〉|Demon City Shinjuku|Monster City Shinjuku
Місто, де мене немає↑Boku dake ga Inai Machi|Erased|The Town Where Only I am Missing, BokuMachi|Erased|Boku dake ga Inai Machi
Місто, де ти живеш↑君のいる町|A Town Where You Live|Kimi no Iru Machi
Місце, що далі за всесвіт↑宇宙よりも遠い場所|A Place Further Than The Universe|Uchuu yori mo Tooi Basho|A Story That Leads to the Antarctica|Yorimoi
Міський мисливець↑シティーハンター|City Hunter
Міський мисливець - Приватні детективи з Шінджюку↑劇場版シティーハンター <新宿PRIVATE EYES>|City Hunter Movie: Shinjuku Private Eyes|City Hunter: Shinjuku Private Eyes
Міський мисливець. 357 Маґнум↑City Hunter: Ai to Shukumei no Magnum|City Hunter: .357 Magnum|City Hunter: A Magnum of Love's Destination, City Hunter: Magnum of Love and Destiny, City Hunter: Magnum of Love and Fate|City Hunter: .357 Magnum|City Hunter: Ai to Shukumei no Magnum
Місяць, Лайка та Носферату↑Tsuki to Laika to Nosferatu|Irina: The Vampire Cosmonaut|Moon, Laika, and the Bloodsucking Princess|Irina: The Vampire Cosmonaut|Tsuki to Laika to Nosferatu
Місія сім'ї Йодзакура↑Yozakura-san Chi no Daisakusen|Mission: Yozakura Family|Mission of Yozakura family|Mission: Yozakura Family|Yozakura-san Chi no Daisakusen
Мішки та зброя / Сакуґан↑サクガン|Sakugan|Sacks&Guns!!|Sakugan Labyrinth Marker|Project ANIMA|削岩ラビリンスマーカー
Міюкі-чян у Країні Чудес / Міюкі-чян у Задзеркаллі↑Fushigi no Kuni no Miyuki-chan|Miyuki-chan in Wonderland|Miyuki-chan In Mirrorland|Miyuki-chan in Wonderland|Fushigi no Kuni no Miyuki-chan
Міґі і Далі↑ミギとダリ|Migi & Dali
НГ Лицар Ламуне & 40↑NG騎士ラムネ＆４０|NG Knight Ramune & 40|Knight Lamune & 40|NG Kishi Ramune & 40
На бій проти титанів (ОВА-1)↑Shingeki no Kyojin OVA|Attack on Titan OAD|Shingeki no Kyojin: Ilse no Techou, Attack on Titan: Ilse's Journal, 進撃の巨人 「イルゼの手帳」|Attack on Titan OAD|Shingeki no Kyojin OVA
На вулиці щастя↑Xingfu Lushang|On Happiness Road|On Happiness Road|Xingfu Lushang
На вулиці щастя↑Xingfu Lushang|On Happiness Road|On Happiness Road|Xingfu Lushang
На старт!↑On Your Mark CHAGE & ASKA|On Your Mark
Навіки мій Санта!↑いつだってMyサンタ！|Itsudatte My Santa!|Watashi no Santa|Always My Santa
Навіть медицина, безсильна для мого брата↑兄に付ける薬はない!|Ani ni Tsukeru Kusuri wa Nai!|Please Take My Brother Away|Kuai Ba Wo Ge Dai Zou
Навіть медицина, безсильна для мого брата! 2↑兄に付ける薬はない! 2|Ani ni Tsukeru Kusuri wa Nai! 2|Please Take My Brother Away 2|Kuai Ba Wo Ge Dai Zou 2
Навіть із синдромом чюнібьо я хочу кохання! (2 сезон)↑中二病でも恋がしたい！戀|Love, Chunibyo & Other Delusions!: Heart Throb|Chuunibyou demo Koi ga Shitai! 2|Chu-2 Byo demo Koi ga Shitai! Ren
Навіть із синдромом чюнібьо я хочу кохання! Фільм↑映画 中二病でも恋がしたい！-Take On Me-|Love, Chunibyo & Other Delusions!: Take On Me|Eiga Chuunibyou demo Koi ga Shitai! Take On Me
Навіть із синдромом чюнібьо я хочу кохання! Фільм↑映画 中二病でも恋がしたい！-Take On Me-|Love, Chunibyo & Other Delusions!: Take On Me|Eiga Chuunibyou demo Koi ga Shitai! Take On Me|Love, Chunibyo & Other Delusions! Take On Me
Навіть із синдромом чюнібьо я хочу кохання! Фільм↑映画 中二病でも恋がしたい！-Take On Me-|Love, Chunibyo & Other Delusions!: Take On Me|Eiga Chuunibyou demo Koi ga Shitai! Take On Me
Надміру турботливе хвостате Божество↑世話やきキツネの仙狐さん|The Helpful Fox Senko-san|Meddlesome Kitsune Senko-san
Наднебесся↑君は彼方|Over the Sky|You are Beyond|KimiKana
Наднебесся↑君は彼方|Over the Sky|You are Beyond|KimiKana|Over the Sky / 君は彼方
Наднебесся↑Kimi wa Kanata|Over the Sky|You are Beyond, KimiKana|Over the Sky|Kimi wa Kanata
Найближча далека зірка↑Ichiban Chikakute Tooi Hoshi|The Nearest Distant Star|The Nearest Distant Star|Ichiban Chikakute Tooi Hoshi
Найвеличніший Володар Демонів переродився у типового невдаху↑Shijou Saikyou no Daimaou, Murabito A ni Tensei suru|The Greatest Demon Lord Is Reborn as a Typical Nobody|The Greatest Maou is Reborned to Get Friends|The Greatest Demon Lord Is Reborn as a Typical Nobody|Shijou Saikyou no Daimaou, Murabito A ni Tensei suru
Найкраще у світі перше кохання↑世界一初恋 TV|Sekai Ichi Hatsukoi - World's Greatest First Love|Sekai-ichi Hatsukoi|Sekai'ichi Hatsukoi|World's Greatest First Love
Найкраще у світі перше кохання 2↑世界一初恋 2|Sekai Ichi Hatsukoi - World's Greatest First Love 2|Sekai-ichi Hatsukoi 2|Sekai'ichi Hatsukoi 2
Найкраще у світі перше кохання ОВА↑世界一初恋 OVA|Sekaiichi Hatsukoi OVA|Sekaiichi Hatsukoi Episode 0|Sekai-ichi Hatsukoi: Onodera Ritsu no Baai|Sekaiichi Hatsukoi Episode 12.5|Sekaiichi Hatsukoi: Yoshino Chiaki no Baai|Sekai'ichi Hatsukoi
Найкраще у світі перше кохання. Освідчення↑世界一初恋~プロポーズ編~|Sekaiichi Hatsukoi: Propose-hen|Sekai'ichi Hatsukoi 2: Propose Hen
Найкраще у світі перше кохання: Випадок Йокодзави Такафумі↑劇場版 世界一初恋 横澤隆史の場合|Sekaiichi Hatsukoi Movie: Yokozawa Takafumi no Baai|Eiga Sekaiichi Hatsukoi|Sekai-ichi Hatsukoi Movie
Найкращий у світі вбивця перероджується в іншому світі як аристократ↑Sekai Saikou no Ansatsusha, Isekai Kizoku ni Tensei suru|The World's Finest Assassin Gets Reincarnated in Another World as an Aristocrat|The world's best assassin, To reincarnate in a different world aristocrat, Ansatsu Kizoku|The World's Finest Assassin Gets Reincarnated in Another World as an Aristocrat|Sekai Saikou no Ansatsusha, Isekai Kizoku ni Tensei suru
Найнебезпечніший Ґейст↑Soukihei MD Geist|M.D. Geist|Most Dangerous Geist|M.D. Geist|Soukihei MD Geist
Найсильніший мудрець непридатної емблеми↑失格紋の最強賢者|The Strongest Sage with the Weakest Crest|The Strongest Sage of Disqualified Crest|Shikkakumon no Saikyokenja
Найслабша приборкувачка вирушила в подорож збирання сміття↑Saijaku Tamer wa Gomi Hiroi no Tabi wo Hajimemashita.|The Weakest Tamer Began a Journey to Pick Up Trash|The Weakest Tamer Began a Journey to Pick Up Trash|Saijaku Tamer wa Gomi Hiroi no Tabi wo Hajimemashita.
Наказ, який змінив світ↑ビッグオーダー|Big Order (TV)|Big Order
Нам не до навчання!↑Bokutachi wa Benkyou ga Dekinai|We Never Learn: BOKUBEN|BokuBen, We Can't Study|We Never Learn: BOKUBEN|Bokutachi wa Benkyou ga Dekinai
Нам не до навчання! 2↑Bokutachi wa Benkyou ga Dekinai!|We Never Learn!: BOKUBEN Season 2|BokuBen, We Can't Study, Bokutachi wa Benkyou ga Dekinai 2nd Season|We Never Learn!: BOKUBEN Season 2|Bokutachi wa Benkyou ga Dekinai!
Намбака↑ナンバカ|Nanbaka|Nambaka|Numbaka|The Numbers
Намбака 2↑Nanbaka 2|Nanbaka Season 2|Nanbaka Season 2|Nanbaka 2
Нана↑NANA [ナナ]|Nana
Нана і Каору↑ナナとカオル|Nana to Kaoru|Nana and Kaoru
Напів зламана музична скринька↑こわれかけのオルゴール|Kowarekake no Orgel|Kowarekake no Orgol|Half-Broken Music Box
Напів зламана музична скринька↑こわれかけのオルゴール|Kowarekake no Orgel|Kowarekake no Orgol|Half-Broken Music Box
Напівдракон↑ドラゴンハーフ|Dragon Half
Напівзламана музична скринька↑こわれかけのオルゴール|Kowarekake no Orgel|Kowarekake no Orgol|Half-Broken Music Box
Напівкровна принцеса демонів↑Hanyou no Yashahime: Sengoku Otogizoushi|Yashahime: Princess Half-Demon|Yashahime: Princess Half-Demon|Hanyou no Yashahime: Sengoku Otogizoushi
Напівкровна принцеса демонів 2↑半妖の夜叉姫 -戦国御伽草子- 弐の章|Yashahime: Princess Half-Demon: The Second Act|Hanyou no Yashahime: Sengoku Otogizoushi 2nd Season
Наречена монстр↑人外さんの嫁|Jingai-san no Yome|Non-Human Creature's Wife
Наречена чаклуна (сезон 2, частина 1)↑Mahoutsukai no Yome Season 2|The Ancient Magus' Bride Season 2|The Ancient Magus Bride 2, Mahoutsukai no Yome 2, Mahoyome|The Ancient Magus' Bride Season 2|Mahoutsukai no Yome Season 2
Наречена чаклуна (сезон 2, частина 2)↑Mahoutsukai no Yome Season 2 Part 2|The Ancient Magus' Bride Season 2 Part 2|The Ancient Magus' Bride Season 2 Part 2|Mahoutsukai no Yome Season 2 Part 2
Наречена чаклуна: Хлопець із Заходу і лицар блакитного шторму↑Mahoutsukai no Yome: Nishi no Shounen to Seiran no Kishi|The Ancient Magus' Bride: The Boy from the West and the Knight of the Blue Storm|The Ancient Magus' Bride OVA, Mahoutsukai no Yome OVA, Mahoutsuaki no Yome OAD, Mahoyome|The Ancient Magus' Bride: The Boy from the West and the Knight of the Blue Storm|Mahoutsukai no Yome: Nishi no Shounen to Seiran no Kishi
Наруто↑ナルト|Naruto|NARUTO
Наруто 4: Загублена вежа / Наруто 4: Загублена Башта↑劇場版 NARUTO-ナルト-疾風伝 ザ・ロストタワー|Naruto Shippuden the Movie 4: The Lost Tower|Naruto Movie 7|Gekijouban Naruto Shippuuden: The Lost Tower|Naruto Shippuden the Movie: The Lost Tower
Наруто Ураганні Хроніки Фільм 3: Спадкоємці Волі Вогню↑ナルト- 疾風伝 火の意志を継ぐ者|Naruto Shippuden the Movie 3: The Will of Fire|Naruto Shippuuden: Gekijouban Naruto Shippuuden: Hi no Ishi o Tsugu Mono|Naruto Shippuuden Movie 3|Naruto Movie 6|Naruto Shippuuden 3: Inheritors of Will of Fire|Naruto Shippuden the Movie: The Will of Fire
Наруто Ураганні Хроніки Фільм 3: Спадкоємці Волі Вогню↑ナルト- 疾風伝 火の意志を継ぐ者|Naruto Shippuden the Movie 3: The Will of Fire|Naruto Shippuuden: Gekijouban Naruto Shippuuden: Hi no Ishi o Tsugu Mono|Naruto Shippuuden Movie 3|Naruto Movie 6|Naruto Shippuuden 3: Inheritors of Will of Fire
Наруто Ураганні Хроніки Фільм 3: Спадкоємці Волі Вогню↑ナルト- 疾風伝 火の意志を継ぐ者|Naruto Shippuden the Movie 3: The Will of Fire|Naruto Shippuuden: Gekijouban Naruto Shippuuden: Hi no Ishi o Tsugu Mono|Naruto Shippuuden Movie 3|Naruto Movie 6|Naruto Shippuuden 3: Inheritors of Will of Fire
Наруто Ураганні хроніки Фільм 1↑Naruto: Shippuuden Movie 1|Naruto Shippuden the Movie 1|Naruto Shippuden Movie, Naruto Movie 4, Gekijouban Naruto Shippuuden|Naruto Shippuden the Movie 1|Naruto: Shippuuden Movie 1
Наруто Фільм 1 - Сутичка ніндзя у Країні Снігу↑劇場版　NARUTO　大活劇！雪姫忍法帖だってばよ!!|Naruto the Movie 1: Ninja Clash in the Land of Snow|Naruto: Daikatsugeki! Yukihime Ninpocho Dattebayo!|Naruto: It's the Snow Princess' Ninja Art Book!
Наруто Фільм 2 - Легенда про камінь Ґелелю↑Naruto Movie 2: Dai Gekitotsu! Maboroshi no Chiteiiseki Dattebayo!|Naruto the Movie 2: Legend of the Stone of Gelel|Naruto THE Movie vol.2, Naruto Movie 2, Gekijouban Naruto|Naruto the Movie 2: Legend of the Stone of Gelel|Naruto Movie 2: Dai Gekitotsu! Maboroshi no Chiteiiseki Dattebayo!
Наруто Фільм 3 - Захисники острова півмісяця↑劇場版 NARUTO -ナルト- 大興奮!みかづき島のアニマル騒動だってばよ|Naruto the Movie 3: Guardians of the Crescent Moon Kingdom|Naruto Movie Volume 3|Naruto: Gekijouban Naruto: Dai Koufun! Mikazuki-jima no Animal Panic Datte ba yo!|Naruto: Guardians of the Crescent Moon Kingdom
Наруто Фільм 3 - Захисники острова півмісяця↑劇場版 NARUTO -ナルト- 大興奮!みかづき島のアニマル騒動だってばよ|Naruto the Movie 3: Guardians of the Crescent Moon Kingdom|Naruto Movie Volume 3|Naruto: Gekijouban Naruto: Dai Koufun! Mikazuki-jima no Animal Panic Datte ba yo!
Наруто проти Конохамару!↑Naruto: Honoo no Chuunin Shiken! Naruto vs. Konohamaru!!|Naruto Shippuden: Chunin Exam on Fire! Naruto vs. Konohamaru!|Naruto Shippuden: Chunin Exam on Fire! Naruto vs. Konohamaru!|Naruto: Honoo no Chuunin Shiken! Naruto vs. Konohamaru!!
Наруто проти Конохамару!↑Naruto: Honoo no Chuunin Shiken! Naruto vs. Konohamaru!!|Naruto Shippuden: Chunin Exam on Fire! Naruto vs. Konohamaru!|Naruto Shippuden: Chunin Exam on Fire! Naruto vs. Konohamaru!|Naruto: Honoo no Chuunin Shiken! Naruto vs. Konohamaru!!
Наруто. Останній фільм↑THE LAST NARUTO THE MOVIE|Naruto Shippuden the Movie 7: The Last|Naruto Movie 10: Naruto the Movie: The Last|Naruto: Shippuuden Movie 7 - The Last
Наруто. Шлях ніндзя↑ROAD TO NINJA NARUTO THE MOVIE|Naruto Shippuden the Movie 6: Road to Ninja|Naruto Movie 9
Наруто. Шлях ніндзя↑ROAD TO NINJA NARUTO THE MOVIE|Naruto Shippuden the Movie 6: Road to Ninja|Naruto Movie 9|Naruto Shippuden the Movie: Road to Ninja
Наруто. Шлях ніндзя (фільм дев'ятий)↑ROAD TO NINJA NARUTO THE MOVIE|Naruto Shippuden the Movie 6: Road to Ninja|Naruto Movie 9
Наруто: Грандіозний Переполох - Фільм 3 / Наруто Фільм 3 - Захисники острова півмісяця↑劇場版 NARUTO -ナルト- 大興奮!みかづき島のアニマル騒動だってばよ|Naruto the Movie 3: Guardians of the Crescent Moon Kingdom|Naruto Movie Volume 3|Naruto: Gekijouban Naruto: Dai Koufun! Mikazuki-jima no Animal Panic Datte ba yo!
Наруто: Знайти темно-червону чотирилисту конюшину!↑Naruto: Akaki Yotsuba no Clover wo Sagase|Naruto: Find the Crimson Four-leaf Clover!|Naruto: Find the Crimson Four Leaf Clover!, Naruto: Jump Festa 2003|Naruto: Find the Crimson Four-leaf Clover!|Naruto: Akaki Yotsuba no Clover wo Sagase
Наруто: Знайти темно-червону чотирилисту конюшину!↑Naruto: Akaki Yotsuba no Clover wo Sagase|Naruto: Find the Crimson Four-leaf Clover!|Naruto: Find the Crimson Four Leaf Clover!, Naruto: Jump Festa 2003|Naruto: Find the Crimson Four-leaf Clover!|Naruto: Akaki Yotsuba no Clover wo Sagase
Наруто: Знайти червону чотирилисту конюшину↑Naruto: Akaki Yotsuba no Clover wo Sagase|Naruto: Find the Crimson Four-leaf Clover!|Naruto: Find the Crimson Four Leaf Clover!, Naruto: Jump Festa 2003|Naruto: Find the Crimson Four-leaf Clover!|Naruto: Akaki Yotsuba no Clover wo Sagase
Наруто: Наруто проти Конохамару↑炎の中忍試験! ナルトvs木ノ葉丸!!|Naruto Shippuden: Chunin Exam on Fire! Naruto vs. Konohamaru!
Наруто: Сутичка ніндзя у Країні Снігу - Фільм 1↑劇場版　NARUTO　大活劇！雪姫忍法帖だってばよ!!|Naruto the Movie 1: Ninja Clash in the Land of Snow|Naruto: Daikatsugeki! Yukihime Ninpocho Dattebayo!|Naruto: It's the Snow Princess' Ninja Art Book!
Наруто: Ураганні Хроніки - Фільм 4: Загублена вежа↑劇場版 NARUTO-ナルト-疾風伝 ザ・ロストタワー|Naruto Shippuden the Movie 4: The Lost Tower|Naruto Movie 7|Gekijouban Naruto Shippuuden: The Lost Tower
Наруто: Ураганні хроніки↑-ナルト- 疾風伝|Naruto Shippuden|Naruto Hurricane Chronicles
Наруто: Ураганні хроніки Фільм 1↑Naruto: Shippuuden Movie 1|Naruto Shippuden the Movie 1|Naruto Shippuden Movie, Naruto Movie 4, Gekijouban Naruto Shippuuden|Naruto Shippuden the Movie 1|Naruto: Shippuuden Movie 1
Наруто: Ураганні хроніки Фільм 1↑Naruto: Shippuuden Movie 1|Naruto Shippuden the Movie 1|Naruto Shippuden Movie, Naruto Movie 4, Gekijouban Naruto Shippuuden|Naruto Shippuden the Movie 1|Naruto: Shippuuden Movie 1
Наруто: Ураганні хроніки – Загублена Башта↑劇場版 NARUTO-ナルト-疾風伝 ザ・ロストタワー|Naruto Shippuden the Movie 4: The Lost Tower|Naruto Movie 7|Gekijouban Naruto Shippuuden: The Lost Tower
Насу: Літо в Андалусії↑茄子 アンダルシアの夏|Nasu: Summer in Andalusia
Насу: Літо в Андалусії↑茄子 アンダルシアの夏|Nasu: Summer in Andalusia|Nasu: Andalusia no Natsu / Nasu: Summer in Andalusia
Насу: Літо в Андалусії↑Nasu: Andalusia no Natsu|Nasu: Summer in Andalusia|Nasu: Summer in Andalusia|Nasu: Andalusia no Natsu
Насу: Перелітний птах із валізою↑茄子 スーツケースの渡り鳥|Nasu: A Migratory Bird with Suitcase|Nasu 2|Nasu: Migratory Bird's Suitcase
Насу: Перелітний птах із валізою↑茄子 スーツケースの渡り鳥|Nasu: A Migratory Bird with Suitcase|Nasu 2|Nasu: Migratory Bird's Suitcase|Nasu: A Migratory Bird with Suitcase / Nasu: Suitcase no Wataridori
Насу: Перелітний птах із валізою↑Nasu: Suitcase no Wataridori|Nasu: A Migratory Bird with Suitcase|Nasu 2, Nasu: Migratory Bird's Suitcase|Nasu: A Migratory Bird with Suitcase|Nasu: Suitcase no Wataridori
Наука закохалася і я доведу це!↑Rikei ga Koi ni Ochita no de Shoumei shitemita.|Science Fell in Love, So I Tried to Prove It|RikeKoi|Science Fell in Love, So I Tried to Prove It|Rikei ga Koi ni Ochita no de Shoumei shitemita.
Наука закохалася і я доведу це! (Сезон 2)↑理系が恋に落ちたので証明してみた。r=1-sinθ（ハート）|Science Fell in Love, So I Tried to Prove It r=1-sinθ|Science Fell in Love|So I Tried to Prove It 2nd Season|Rikekoi|Rikei ga Koi ni Ochita no de Shoumei shitemita. r=1-sinθ
Наусіка з Долини Вітрів / Навсікая з Долини Вітрів↑風の谷のナウシカ|Nausicaä of the Valley of the Wind|Nausicaa of the Valley of the Wind|Kaze no Tani no Nausicaa|Warriors of the Wind
Наусіка з долини вітрів↑風の谷のナウシカ|Nausicaä of the Valley of the Wind|Nausicaa of the Valley of the Wind|Kaze no Tani no Nausicaa|Warriors of the Wind
Наче зорепад↑流れ星レンズ|Nagareboshi Lens|Shooting Star Lens|Ribon Festa 2012|Ribbon Festa 2012
Наш дощовий протокол↑Bokura no Ame-iro Protocol|Protocol: Rain|Our Rainy Protocol|Protocol: Rain|Bokura no Ame-iro Protocol
Наше кохання завжди було на відстані 10 сантиметрів↑Itsudatte Bokura no Koi wa 10 cm Datta.|Our love has always been 10 centimeters apart.|Our love has always been 10 centimeters apart.|Itsudatte Bokura no Koi wa 10 cm Datta.|Our love has always been 10 centimeters apart
Нащадки пітьми↑Yami no Matsuei|Descendants of Darkness|Descent into Darkness, The Darker Descendant|Descendants of Darkness|Yami no Matsuei
Не знущайся з мене, Наґаторо!↑Ijiranaide, Nagatoro-san|Don't Toy with Me, Miss Nagatoro|Please don't bully me, Nagatoro|Don't Toy with Me, Miss Nagatoro|Ijiranaide, Nagatoro-san
Не знущайся з мене, Наґаторо! Повторний удар! (Сезон 2)↑Ijiranaide, Nagatoro-san 2nd Attack|Don't Toy with Me, Miss Nagatoro 2nd Attack|Don't Toy with Me, Miss Nagatoro 2nd Season, Ijiranaide, Nagatoro-san 2nd Season|Don't Toy with Me, Miss Nagatoro 2nd Attack|Ijiranaide, Nagatoro-san 2nd Attack
Не може моя сестра бути такою милою↑Ore no Imouto ga Konnani Kawaii Wake ga Nai|OreImo|My Little Sister Can't Be This Cute|OreImo|Ore no Imouto ga Konnani Kawaii Wake ga Nai
Не самотнє життя↑ひとりぼっちの○○生活|Hitoribocchi no Marumaru Seikatsu|Hitoribocchi no ○○ Seikatsu|Hitori Bocchi's ○○ Lifestyle
Не їж сиру печінку, бо перетворишся на свинку↑Buta no Liver wa Kanetsu Shiro|Butareba -The Story of a Man Who Turned into a Pig-|Heat the Pig Liver: The Story of a Man Turned Into a Pig, ButaLiver|Butareba -The Story of a Man Who Turned into a Pig-|Buta no Liver wa Kanetsu Shiro
Небажано немертвий шукач пригод↑Nozomanu Fushi no Boukensha|The Unwanted Undead Adventurer|The Unwanted Undead Adventurer|Nozomanu Fushi no Boukensha
Небеса дракона↑ドラゴンズヘブン|Dragon's Heaven
Небесне Благословення↑天官賜福|Heaven Official's Blessing|TGCF|Tian Guan Ci Fu
Небесне вторгнення↑Tenkuu Shinpan|High-Rise Invasion|Sky-High Survival, Sky Violation|High-Rise Invasion|Tenkuu Shinpan
Небесний замок Лапута↑天空の城ラピュタ|Castle in the Sky|Tenkuu no Shiro Rapyuta
Небесний замок Лапута↑天空の城ラピュタ|Castle in the Sky|Tenkuu no Shiro Rapyuta
Небесні вовки: Мисливець Сіріус↑Sirius|Sirius the Jaeger|Tenrou|Sirius the Jaeger|Sirius
Небесні тихоходи↑スカイ・クロラ|The Sky Crawlers
Небо↑sola|Sola Specials|Sola OVA
Небо і земля: Бій без правил↑天上天下ULTIMATE FIGHT|Tenjho Tenge: The Ultimate Fight|Ultimate Fight
Невдаха↑UNDER THE DOG|Under the Dog|UNDER THE DOG EPISODE 0
Неверленд. Омріяна нами, країна вічного дитинства↑Yakusoku no Neverland|The Promised Neverland|The Promised Neverland|Yakusoku no Neverland
Невже шукати дівчину в підземеллі - неправильно?↑Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka|Is It Wrong to Try to Pick Up Girls in a Dungeon?|DanMachi, Is It Wrong That I Want to Meet You in a Dungeon|Is It Wrong to Try to Pick Up Girls in a Dungeon?|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka
Невже шукати дівчину в підземеллі - неправильно? (4 сезон, частина 1)↑Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka IV: Shin Shou - Meikyuu-hen|Is It Wrong to Try to Pick Up Girls in a Dungeon? IV|DanMachi 4th Season, Is It Wrong That I Want to Meet You in a Dungeon 4th Season|Is It Wrong to Try to Pick Up Girls in a Dungeon? IV|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka IV: Shin Shou - Meikyuu-hen
Невже шукати дівчину в підземеллі - неправильно? (4 сезон, частина 2)↑Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka IV: Fuka Shou - Yakusai-hen|Is It Wrong to Try to Pick Up Girls in a Dungeon? IV Part 2|DanMachi 4th Season Part 2, Is It Wrong That I Want to Meet You in a Dungeon 4th Season Part 2|Is It Wrong to Try to Pick Up Girls in a Dungeon? IV Part 2|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka IV: Fuka Shou - Yakusai-hen
Невже шукати дівчину в підземеллі - неправильно? (Сезон 3)↑ダンジョンに出会いを求めるのは間違っているだろうかIII|Is It Wrong to Try to Pick Up Girls in a Dungeon? III|DanMachi 3rd Season|Is It Wrong That I Want to Meet You in a Dungeon 3rd Season
Невже шукати дівчину в підземеллі - неправильно? 2↑ダンジョンに出会いを求めるのは間違っているだろうか 過去と未来[パスト&フューチャー]|Is It Wrong to Try to Pick Up Girls in a Dungeon? II: Past & Future|DanMachi Recap|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka II Episode 0
Невже шукати дівчину в підземеллі - неправильно? Стріла Оріона↑Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka Movie: Orion no Ya|Is It Wrong to Try to Pick Up Girls in a Dungeon?: Arrow of the Orion|DanMachi Movie, Is It Wrong That I Want to Meet You in a Dungeon Movie|Is It Wrong to Try to Pick Up Girls in a Dungeon?: Arrow of the Orion|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka Movie: Orion no Ya
Невже шукати дівчину в підземеллі неправильно? Ораторія мечів↑Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka Gaiden: Sword Oratoria|Sword Oratoria: Is It Wrong to Try to Pick Up Girls in a Dungeon? On the Side|Danmachi Sword Oratoria|Sword Oratoria: Is It Wrong to Try to Pick Up Girls in a Dungeon? On the Side|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka Gaiden: Sword Oratoria
Невизнаний в академії Короля Демонів (1 сезон)↑Maou Gakuin no Futekigousha: Shijou Saikyou no Maou no Shiso, Tensei shite Shison-tachi no Gakkou e Kayou|The Misfit of Demon King Academy|The Misfit of Demon King Academy: History's Strongest Demon King Reincarnates and Goes to School with His Descendants|The Misfit of Demon King Academy|Maou Gakuin no Futekigousha: Shijou Saikyou no Maou no Shiso, Tensei shite Shison-tachi no Gakkou e Kayou
Невизнаний в академії Короля Демонів (2 сезон)↑魔王学院の不適合者 II～史上最強の魔王の始祖、転生して子孫たちの学校へ通う～|The Misfit of Demon King Academy Ⅱ|Maou Gakuin no Futekigousha: Shijou Saikyou no Maou no Shiso|Tensei shite Shison-tachi no Gakkou e Kayou 2nd Season|The Misfit of Demon King Academy 2nd Season
Невинний погляд↑アイズピュア|I''s Pure|I''s OVA|Aizu Pure|I"s Pure
Негідники не мріють про сестру на прогулянці↑Seishun Buta Yarou wa Odekake Sister no Yume wo Minai|Rascal Does Not Dream of a Sister Venturing Out|Rascal Does Not Dream of a Sister Venturing Out|Seishun Buta Yarou wa Odekake Sister no Yume wo Minai
Негідники не мріють про шляхетних дівчат↑Seishun Buta Yarou wa Yumemiru Shoujo no Yume wo Minai|Rascal Does Not Dream of a Dreaming Girl|Rascal Does Not Dream of a Dreaming Girl|Seishun Buta Yarou wa Yumemiru Shoujo no Yume wo Minai
Негідники не мріють про шляхетних кроличок↑青春ブタ野郎はゆめみる少女の夢を見ない|Rascal Does Not Dream of a Dreaming Girl
Негідники не мріють про шляхетних кроличок↑青春ブタ野郎はゆめみる少女の夢を見ない|Rascal Does Not Dream of a Dreaming Girl
Негідники не мріють про шляхетних кроличок↑Seishun Buta Yarou wa Bunny Girl Senpai no Yume wo Minai|Rascal Does Not Dream of Bunny Girl Senpai|AoButa|Rascal Does Not Dream of Bunny Girl Senpai|Seishun Buta Yarou wa Bunny Girl Senpai no Yume wo Minai
Недо_сьома Нія↑ニア アンダーセブン|NieA Under 7|NieA_7
Неділя без Бога↑神さまのいない日曜日|Sunday Without God|The Sunday Without God|Kami-Nai|Kami-sama no Inai Nichiyoubi
Незбагненна Ахарен↑阿波連さんははかれない|Aharen-san wa Hakarenai|Aharen Is Indecipherable
Незворушний Рохан Кішібе↑Kishibe Rohan wa Ugokanai|Thus Spoke Kishibe Rohan|Rohan Kishibe Does Not Move|Thus Spoke Kishibe Rohan|Kishibe Rohan wa Ugokanai
Нездоланні↑BEATLESS|Beatless
Незнайомець на узбережжі↑海辺のエトランゼ|The Stranger by the Shore|L'étranger du plage|L'étranger de la plage|The Stranger by the Beach
Незнайомець на узбережжі↑Umibe no Étranger|The Stranger by the Shore|L'étranger du plage, L'étranger de la plage, The Stranger by the Beach|The Stranger by the Shore|Umibe no Étranger
Незріла Домовласниця↑Ooya-san wa Shishunki!|Landlord is in Puberty!|Landlord is in Puberty!|Ooya-san wa Shishunki!
Неймовірні / Химерні пригоди ДжоДжо – Золотий вітер↑ジョジョの奇妙な冒険 黄金の風|JoJo's Bizarre Adventure: Golden Wind|JoJo's Bizarre Adventure Part 5: Golden Wind|JoJo no Kimyou na Bouken Part 5: Ougon no Kaze|Le Bizzarre Avventure Di GioGio Parte 5: Vento Aureo
Неймовірні / Химерні пригоди ДжоДжо: Кам'яний океан↑JoJo no Kimyou na Bouken Part 6: Stone Ocean|JoJo's Bizarre Adventure: Stone Ocean|JoJo's Bizarre Adventure Part 6: Stone Ocean|JoJo's Bizarre Adventure: Stone Ocean|JoJo no Kimyou na Bouken Part 6: Stone Ocean
Неймовірні Диво-Дітки: БЕЗ МЕЖ↑Zettai Karen Children: The Unlimited - Hyoubu Kyousuke|Unlimited Psychic Squad|The Unlimited Hyobu Kyosuke|Unlimited Psychic Squad|Zettai Karen Children: The Unlimited - Hyoubu Kyousuke
Неймовірні пригоди ДжоДжо (1 сезон)↑ジョジョの奇妙な冒険|JoJo's Bizarre Adventure (2012)|JoJo no Kimyou na Bouken (2012)|Battle Tendency|Phantom Blood|Sentou Chouryuu|JoJo's Bizarre Adventure The Animation
Неймовірні пригоди ДжоДжо ОВА↑JoJo no Kimyou na Bouken|JoJo's Bizarre Adventure|JoJo's Bizarre Adventure OVA 1|JoJo's Bizarre Adventure|JoJo no Kimyou na Bouken
Неймовірні пригоди ДжоДжо: Незламний Діамант↑ジョジョの奇妙な冒険 ダイヤモンドは砕けない|JoJo's Bizarre Adventure: Diamond Is Unbreakable|JoJo no Kimyou na Bouken Part 4: Diamond wa Kudakenai|Diamond is not Crash
Неймовірні пригоди ДжоДжо: Пригода ОВА↑JoJo no Kimyou na Bouken: Adventure|JoJo's Bizarre Adventure (OVA)|JoJo's Bizarre Adventure (2000)|JoJo's Bizarre Adventure (OVA)|JoJo no Kimyou na Bouken: Adventure
Неймовірні пригоди ДжоДжо: Хрестоносці зоряного пилу↑JoJo no Kimyou na Bouken Part 3: Stardust Crusaders|JoJo's Bizarre Adventure: Stardust Crusaders|Dai San Bu Kuujou Joutarou: Mirai e no Isan, JoJo's Bizarre Adventure Part 3|JoJo's Bizarre Adventure: Stardust Crusaders|JoJo no Kimyou na Bouken Part 3: Stardust Crusaders
Неймовірні пригоди ДжоДжо: Хрестоносці зоряного пилу (2 сезон)↑JoJo no Kimyou na Bouken Part 3: Stardust Crusaders 2nd Season|JoJo's Bizarre Adventure: Stardust Crusaders - Battle in Egypt|JoJo's Bizarre Adventure Part 3, JoJo's Bizarre Adventure: Stardust Crusaders - Egypt Arc|JoJo's Bizarre Adventure: Stardust Crusaders - Battle in Egypt|JoJo no Kimyou na Bouken Part 3: Stardust Crusaders 2nd Season
Нелюд (1 сезон)↑Ajin|Ajin: Demi-Human|Ajin|Ajin: Demi-Human
Нелюд (2 сезон)↑Ajin Part 2|Ajin: Demi-Human 2nd Season|Ajin 2nd Season,|Ajin: Demi-Human 2nd Season|Ajin Part 2
Немертвий і Невдача↑アンデッドアンラック|Undead Unluck
Неосяжна блакить↑Grand Blue|Grand Blue Dreaming|Grand Blue Dreaming|Grand Blue
Непорочна Марія↑Junketsu no Maria|Maria the Virgin Witch|Junketsu no Maria: Sorcière de gré, pucelle de force|Maria the Virgin Witch|Junketsu no Maria
Непристойно пристойний світ↑Shimoneta to Iu Gainen ga Sonzai Shinai Taikutsu na Sekai|SHIMONETA: A Boring World Where the Concept of Dirty Jokes Doesn't Exist|Shimoseka|SHIMONETA: A Boring World Where the Concept of Dirty Jokes Doesn't Exist|Shimoneta to Iu Gainen ga Sonzai Shinai Taikutsu na Sekai
Непутящий учень школи магії↑Mahouka Koukou no Rettousei|The Irregular at Magic High School|The Irregular at Magic High School|Mahouka Koukou no Rettousei
Непутящий учень школи магії (сезон 3)↑Mahouka Koukou no Rettousei 3rd Season|The Irregular at Magic High School Season 3|The Irregular at Magic High School Season 3|Mahouka Koukou no Rettousei 3rd Season
Непутящий учень школи магії: Арка візитера (сезон 2)↑Mahouka Koukou no Rettousei: Raihousha-hen|The Irregular at Magic High School: Visitor Arc|Mahouka Koukou no Rettousei 2nd Season, The Irregular at Magic High School Season 2|The Irregular at Magic High School: Visitor Arc|Mahouka Koukou no Rettousei: Raihousha-hen
Непутящий учень школи магії: Дівчина, що Викликає Зорі↑Mahouka Koukou no Rettousei Movie: Hoshi wo Yobu Shoujo|The Irregular at Magic High School The Movie - The Girl Who Summons The Stars|Gekijouban Mahouka Koukou no Rettousei|The Irregular at Magic High School The Movie - The Girl Who Summons The Stars|Mahouka Koukou no Rettousei Movie: Hoshi wo Yobu Shoujo
Непутящий учень школи магії: Дівчина, що викликає зорі↑劇場版 魔法科高校の劣等生 星を呼ぶ少女|The Irregular at Magic High School The Movie - The Girl Who Summons The Stars|Gekijouban Mahouka Koukou no Rettousei|Gekijouban Mahouka koukou no rettousei: Hoshi o yobu shoujo
Непутящий учень школи магії: Дівчина, що викликає зорі↑Mahouka Koukou no Rettousei Movie: Hoshi wo Yobu Shoujo|The Irregular at Magic High School The Movie - The Girl Who Summons The Stars|Gekijouban Mahouka Koukou no Rettousei|The Irregular at Magic High School The Movie - The Girl Who Summons The Stars|Mahouka Koukou no Rettousei Movie: Hoshi wo Yobu Shoujo
Непутящий учень школи магії: Спогади.↑Mahouka Koukou no Rettousei: Tsuioku-hen|The Irregular at Magic High School: Reminiscence Arc|The Irregular at Magic High School: Reminiscence Arc|Mahouka Koukou no Rettousei: Tsuioku-hen
Нескінченний Дендрограм↑<Infinite Dendrogram>-インフィニット・デンドログラム-|Infinite Dendrogram
Нестерпні прибульці↑Urusei Yatsura (2022)|Urusei Yatsura|Those Obnoxious Aliens,The Return of Lum, Lum, the Invader Girl|Urusei Yatsura|Urusei Yatsura (2022)
Нестерпні прибульці (Сезон 2)↑うる星やつら第2期|Urusei Yatsura (2022) 2nd Season|Urusei Yatsura Season 2
Нечисть↑屍鬼|Shiki|Corpse Demon
Низькорівневий персонаж Томозакі↑Jaku-Chara Tomozaki-kun|Bottom-Tier Character Tomozaki|Jakusha Character Tomozaki-kun, The Low Tier Character "Tomozaki-kun"|Bottom-Tier Character Tomozaki|Jaku-Chara Tomozaki-kun
Низькорівневий персонаж Томозакі 2↑Jaku-Chara Tomozaki-kun 2nd Stage|Bottom-Tier Character Tomozaki 2nd Stage|Bottom-Tier Character Tomozaki 2nd Stage|Jaku-Chara Tomozaki-kun 2nd Stage
Ноблес (Сезон 1)↑NOBLESSE -ノブレス-|Noblesse|노블레스
Ноблес. Пробудження↑Noblesse: Awakening|Noblesse Episode 0
Ноблес. Пробудження↑Noblesse: Awakening|Noblesse Episode 0
Ноблес: початок руйнування↑NOBLESSE 파멸의 시작|Noblesse: Pamyeol-ui Sijak|Noblesse: The Beginning of Destruction
Ноблес: початок руйнування↑NOBLESSE 파멸의 시작|Noblesse: Pamyeol-ui Sijak|Noblesse: The Beginning of Destruction
Ноблес: початок руйнування↑NOBLESSE 파멸의 시작|Noblesse: Pamyeol-ui Sijak|Noblesse: The Beginning of Destruction
Нобунаґан↑ノブナガン|Nobunagun|Nobunagan
Нова Брама↑THE NEW GATE|The New Gate
Нова Гра!↑NEW GAME!|New Game!
Нова Гра!! (2 сезон)↑NEW GAME!!|New Game!!|New Game! Second Season
Нова гра! Моя перша відпустка у компанії New Game!: Watashi, Shain Ryokou tte Hajimete nano de…↑NEW GAME! 私、社員旅行って初めてなので…|New Game! Watashi, Shain Ryokou tte Hajimete nanode...|New Game! OVA: My First Time on a Company Vacation...|New Game Episode 13
Нова ера – Євангеліон↑Shinseiki Evangelion|Neon Genesis Evangelion|NGE, Evangelion (1995)|Neon Genesis Evangelion|Shinseiki Evangelion
Нова ера – Євангеліон - Кінець Євангеліону↑Shinseiki Evangelion Movie: Air/Magokoro wo, Kimi ni|Neon Genesis Evangelion: The End of Evangelion|Shinseiki Evangelion Gekijouban: The End of Evangelion, EoE|Neon Genesis Evangelion: The End of Evangelion|Shinseiki Evangelion Movie: Air/Magokoro wo, Kimi ni
Нове втілення богині: Токійське одкровення↑Shin Megami Tensei: Tokyo Mokushiroku|Tokyo Revelation|True Goddess Reborn: Tokyo Revelation|Tokyo Revelation|Shin Megami Tensei: Tokyo Mokushiroku
Новий Домініон: Танкова поліція↑特捜戦車隊ドミニオン|New Dominion Tank Police|Tokusou Sensha-tai Dominion|Tokusou Senshatai Dominion
Нові Токійські Няв-нявки↑東京ミュウミュウ にゅ～♡|Tokyo Mew Mew New
Нові останні історії↑Zoku Owarimonogatari|Zoku Owarimonogatari|Zoku Owarimonogatari
Нодаме Кантабіле↑のだめカンタービレ|Nodame Cantabile
Нодаме Контабіле: Паризька глава↑のだめカンタービレ 巴里編|Nodame Cantabile Paris Chapter|Nodame Cantabile Pari-hen
Нозакі і його шьоджьо-манґа↑月刊少女野崎くん|Monthly Girls' Nozaki-kun|Gekkan Shoujo Nozaki-kun
Нотатки про подорож до Йокогами за покупками↑ヨコハマ買い出し紀行|Yokohama Kaidashi Kikou|YKK|Yokohama Shopping Log|Yokohama Shopping Trip
Ночі з котом↑Yoru wa Neko to Issho|Nights with a Cat|Zutto Neko Shoshinsha|Nights with a Cat|Yoru wa Neko to Issho
Нуар↑ノワール|Noir
Нулл і Пета↑ぬるぺた|Null & Peta
Нульовий Едем↑EDENS ZERO|Edens Zero
Нульовий Едем (2 сезон)↑エデンズ ゼロ|Edens Zero 2nd Season
Нумо чвакнемось↑LET'S　ぬぷぬぷっ|Let's Nupu Nupu
Нянпір↑Nyanpire The Animation|Nyanpire The Animation|Nyanpire The Animation
Ніер: Автомата Вер.1.1a↑NieR:Automata Ver1.1a
Ніклаас, хлопчик із Фландрії↑超ゼンマイロボ パトラッシュ|Chou Zenmairobo: Patrasche|Flanders no Inu|Chou Zenmai Robo Patrush
Нікуко з рибальського містечка↑Gyokou no Nikuko-chan|Fortune Favors Lady Nikuko|Fortune Favors Lady Nikuko|Gyokou no Nikuko-chan
Нікуко з рибальського містечка↑Gyokou no Nikuko-chan|Fortune Favors Lady Nikuko|Fortune Favors Lady Nikuko|Gyokou no Nikuko-chan
Нікуко з рибальського містечка↑Gyokou no Nikuko-chan|Fortune Favors Lady Nikuko|Fortune Favors Lady Nikuko|Gyokou no Nikuko-chan
Нінджя Камуї↑Ninja Kamui
Нінджя під прикриттям↑アンダーニンジャ|Under Ninja
Ніндзя-воїн Тобікаге↑Ninja Senshi Tobikage|Ninja Robots|Ninja Robots|Ninja Senshi Tobikage
Ніч за трикутним вікном↑Sankaku Mado no Sotogawa wa Yoru|The Night Beyond the Tricornered Window|The Night Beyond the Tricornered Window|Sankaku Mado no Sotogawa wa Yoru
Ніч закоротка, гуляй дівчино↑夜は短し歩けよ乙女|Night Is Short, Walk on Girl
Ніч закоротка, гуляй дівчино↑夜は短し歩けよ乙女|Night Is Short, Walk on Girl|Night Is Short, Walk On Girl / 夜は短し歩けよ乙女
Ніч закоротка, гуляй дівчино↑Yoru wa Mijikashi Arukeyo Otome|Night Is Short, Walk on Girl|Night Is Short, Walk on Girl|Yoru wa Mijikashi Arukeyo Otome
Ніч на галактичній залізниці↑Ginga Tetsudou no Yoru|Night on the Galactic Railroad|Night on the Galactic Railroad|Ginga Tetsudou no Yoru
Нічний світ↑夜の国|Yoru no Kuni|Night World|Night Country
Нічні воїни: Мисливці на вампірів↑Vampire Hunter|Night Warriors: Darkstalkers' Revenge|Vampire Hunter: The Animated Series|Night Warriors: Darkstalkers' Revenge|Vampire Hunter
Об'єднуйтесь↑UniteUp!
Обан: Зоряні Гонки↑オーバン・スターレーサーズ|Oban Star-Racers|Oban Star Racers
Обганяй!↑オーバーテイク！|Overtake!
Обертаний пінгвобарабан↑Mawaru Penguindrum|Penguindrum|Penguindrum|Mawaru Penguindrum
Оберіг Хімарі↑おまもりひまり|Omamori Himari|Protective Charm Himari|OmaHima
Обставини у моїй ванній↑Orenchi no Furo Jijou|Merman in my Tub|Orefuro|Merman in my Tub|Orenchi no Furo Jijou
Обіцяний Неверленд (Сезон 2)↑Yakusoku no Neverland 2nd Season|The Promised Neverland Season 2|The Promised Neverland Season 2|Yakusoku no Neverland 2nd Season
Ода Кориця Нобунаґа↑織田シナモン信長|Oda Cinnamon Nobunaga|Oda Shinamon Nobunaga
Один: Сезон сяйва↑ONE ～輝く季節へ～|One: Kagayaku Kisetsu e|One: To a Shining Season
Одинадцять блискавок. Атака найсильнішої армії Людожер↑劇場版イナズマイレブン 最強軍団オーガ襲来|Inazuma Eleven: Saikyou Gundan Ogre Shuurai|Gekijouban Inazuma Eleven: Saikyou Gundan Ogre Shuurai|Inazuma Eleven the Movie
Одна кімната↑One Room|One Room Special|One Room Episode 13
Одна морока з тією цілителькою↑Kono Healer, Mendokusai|Don't Hurt Me, My Healer!|This Healer's a Handful|Don't Hurt Me, My Healer!|Kono Healer, Mendokusai
Одна із них моя сестра!↑Kono Naka ni Hitori, Imouto ga Iru!|NAKAIMO - My Little Sister Is Among Them!|NakaImo, One of Them is My Younger Sister!, Who is Imouto?|NAKAIMO - My Little Sister Is Among Them!|Kono Naka ni Hitori, Imouto ga Iru!
Одного разу↑わんおふ -one off-|One Off
Однокласники↑同級生 夏の終わりに|End of Summer|Dokyusei|Doukyuusei|Classmates
Однокласники↑同級生|Doukyusei -Classmates-
Однокласники↑同級生|Doukyusei -Classmates-|Dou kyu sei Classmates
Однокімнатка героя та лорд-демона 1 рівня↑Lv1 Maou to One Room Yuusha|Level 1 Demon Lord and One Room Hero|Level 1 Demon Lord and One Room Hero|Lv1 Maou to One Room Yuusha
Озброєні школярі: Баскет-Армія↑武装中学生 バスケットアーミー|Busou Chuugakusei: Basket Army|Basket Army
Озума↑オズマ|Ozma|Ozuma
Окультна академія↑世紀末オカルト学院|Occult Academy|Zaidanhoujin Occult Designer Gakuin|Seikimatsu Occult Academy
Окультна дев'ятка↑Occultic;Nine －オカルティック・ナイン－|Occultic;Nine|Occultic9|Occultic Nine
Олімпія Кіклос↑Bessatsu Olympia Kyklos|Extra Olympia Kyklos|Extra Olympia Kyklos|Bessatsu Olympia Kyklos
Оновлений світ: Початок/Завантаження/Кінець↑アラタなるセカイ WORLD'S/START/LOAD/END|World's End|Arata naru Sekai: Mirai-hen|Arata-naru Sekai|Aratanaru Sekai|The World of Arata|Arata-naru Sekai: World's/Start/Load/End
Онтама!↑おんたま!|Ontama!
Онук Нураріхьона↑Nurarihyon no Mago|Nura: Rise of the Yokai Clan|The Grandson of Nurarihyon, Grandchild of Nurarihyon|Nura: Rise of the Yokai Clan|Nurarihyon no Mago
Онук Нураріхьона. Тисячорічна столиця духів↑Nurarihyon no Mago: Sennen Makyou|Nura: Rise of the Yokai Clan - Demon Capital|Nurarihyon no Mago 2, The Grandson of Nurarihyon 2, Grandchild of Nurarihyon 2|Nura: Rise of the Yokai Clan - Demon Capital|Nurarihyon no Mago: Sennen Makyou
Онук мудреця↑Kenja no Mago|Wise Man's Grandchild|Philosopher's Grandson, Magi's Grandson|Wise Man's Grandchild|Kenja no Mago
Онікірімару↑Onikirimaru|Ogre Slayer|Ogre Slayer|Onikirimaru
Онімуша: Воїн оні↑鬼武者|Onimusha
Оніхей↑鬼平|Onihei
Оніґірі↑鬼斬|Onigiri|Demon Cutter|Demon Slayer
Операція «Юкіказе»↑Sentou Yousei Yukikaze|Yukikaze|Battle Fairy Yukikaze, Yukikaze Operation, Fairy Air Force|Yukikaze|Sentou Yousei Yukikaze
Оповідь про Хейке↑Heike Monogatari|The Heike Story|The Heike Story|Heike Monogatari
Опора↑カナメヲ|Kanamewo|A linchpin
Опір крові↑ストライク・ザ・ブラッド|Strike the Blood|SutoBura
Опір крові II↑Strike the Blood II|Strike the Blood Second|Strike the Blood Second|Strike the Blood II
Опір крові ІІІ↑ストライク・ザ・ブラッドⅢ|Strike the Blood III|Strike the Blood Third
Орган геноциду↑虐殺器官|Genocidal Organ|Project Itoh
Орган геноциду↑虐殺器官|Genocidal Organ|Project Itoh
Орган геноциду↑Gyakusatsu Kikan|Genocidal Organ|Project Itoh|Genocidal Organ|Gyakusatsu Kikan
Орґусс 02↑超時空世紀オーガス02|Choujikuu Seiki Orguss 02|The Super Dimension Century Orguss 02
Оселя Зла - Вендетта↑Biohazard: Vendetta|Resident Evil: Vendetta|Resident Evil: Vendetta|Biohazard: Vendetta
Оселя похмурого володаря Мононокеану↑Fukigen na Mononokean|The Morose Mononokean|The Morose Mononokean|Fukigen na Mononokean
Оселя похмурого володаря Мононокеану 2↑不機嫌なモノノケ庵 續|The Morose Mononokean II|Fukigen na Mononokean 2nd Season
Оскільки я лиходійка, я приборкаю фінального боса↑Akuyaku Reijou nanode Last Boss wo Kattemimashita|I'm the Villainess, So I'm Taming the Final Boss|Akulas|I'm the Villainess, So I'm Taming the Final Boss|Akuyaku Reijou nanode Last Boss wo Kattemimashita
Остання Фантазія↑ファイナルファンタジー|Final Fantasy: The Spirits Within|Final Fantasy
Остання фантазія 7: Діти пришестя↑ファイナルファンタジーVII アドベントチルドレン|Final Fantasy VII: Advent Children|Final Fantasy 7: Advent Children
Останнє поле битви між тобою та мною, або Свята війна створення світу↑Kimi to Boku no Saigo no Senjou, Aruiwa Sekai ga Hajimaru Seisen|Our Last Crusade or the Rise of a New World|The Last Battlefield Between You and I, or Perhaps the Beginning of the World's Holy War, Kimisen|Our Last Crusade or the Rise of a New World|Kimi to Boku no Saigo no Senjou, Aruiwa Sekai ga Hajimaru Seisen
Останні історії (1 сезон)↑Owarimonogatari|Owarimonogatari|End Story|Owarimonogatari
Останні історії (сезон 2)↑Owarimonogatari 2nd Season|Owarimonogatari Second Season|End Story 2nd Season|Owarimonogatari Second Season|Owarimonogatari 2nd Season
Останній Вигнанець: Сріблясті Крила Фам↑Last Exile: Ginyoku no Fam|Last Exile: Fam, the Silver Wing|Last Exile: Fam, the Silver Wing|Last Exile: Ginyoku no Fam
Останній Серафим (1 сезон)↑Owari no Seraph|Seraph of the End: Vampire Reign|Seraph of the End|Seraph of the End: Vampire Reign|Owari no Seraph
Останній Серафим (2 сезон)↑Owari no Seraph: Nagoya Kessen-hen|Seraph of the End: Battle in Nagoya|Owari no Seraph 2nd Season, Seraph of the End 2nd Season|Seraph of the End: Battle in Nagoya|Owari no Seraph: Nagoya Kessen-hen
Останній викликач↑最后的召唤师|The Last Summoner|Zui Hou De Zhao Huan Shi
Останній: Наруто фільм↑THE LAST NARUTO THE MOVIE|Naruto Shippuden the Movie 7: The Last|Naruto Movie 10: Naruto the Movie: The Last|Naruto: Shippuuden Movie 7 - The Last
Острів↑Island (TV)|Island|Island|Island (TV)
Острів Джованні↑Giovanni no Shima|Giovanni's Island|Giovanni no Shima|Giovanni's Island
Острів велетенських комах↑Kyochuu Rettou Movie|The Island of Giant Insects Movie|The Island of Giant Insects Movie|Kyochuu Rettou Movie
Острів забуття - Харука та чарівне дзеркало↑Hottarake no Shima: Haruka to Mahou no Kagami|Oblivion Island: Haruka and the Magic Mirror|Oblivion Island: Haruka and the Magic Mirror|Hottarake no Shima: Haruka to Mahou no Kagami
Ось чому я не можу зробити ЦЕ↑だから僕は、Hができない。|So, I Can't Play H!|Dakara boku-ha H ga Dekinai.|Dakara Boku wa|Ecchi ga Dekinai
Офісний Планктон Оззі↑Kachou Ouji|Legend of Black Heaven|Kachou Ouji: Hard Rock Save the Space|Legend of Black Heaven|Kachou Ouji
П'ять наречених↑五等分の花嫁*|5-toubun no Hanayome*
П'ять наречених (Сезон 2)↑5-toubun no Hanayome ∬|The Quintessential Quintuplets 2|Gotoubun no Hanayome 2nd Season, The Five Wedded Brides 2nd Season, 5-toubun no Hanayome 2nd Season, The Quintessential Quintuplets 2nd Season|The Quintessential Quintuplets 2|5-toubun no Hanayome ∬
П'ять наречених Спешл↑五等分の花嫁*|5-toubun no Hanayome*
П'ять наречених Фільм↑映画 五等分の花嫁|The Quintessential Quintuplets Movie|Gotoubun no Hanayome|The Five Wedded Brides|The Quintessential Quintuplets
П'ять наречених Фільм↑映画 五等分の花嫁|The Quintessential Quintuplets Movie|Gotoubun no Hanayome|The Five Wedded Brides|The Quintessential Quintuplets
П'ять наречених Фільм↑5-toubun no Hanayome Movie|The Quintessential Quintuplets Movie|Gotoubun no Hanayome, The Five Wedded Brides, The Quintessential Quintuplets|The Quintessential Quintuplets Movie|5-toubun no Hanayome Movie
П.А.П: Прочитай або Помри↑R.O.D リード・オア・ダイ|R.O.D - Read or Die|ROD OVA|Read or Die OVA
ПОП ЕПІК ТІМА↑ボブネミミッミ|Bobunemimimmi Collection|Pop Team Epic|Bob Team Epic|Poputepipikku
ПОП ЕПІК ТІМА СЕЗОН 2↑Poputepipikku 2nd Season|Pop Team Epic Season 2|Pop Team Epic Season 2|Poputepipikku 2nd Season
Павучок↑Wasurenagumo|Li'l Spider Girl|Wakate Animator Ikusei Project, 2011 Young Animator Training Project, Anime Mirai 2011|Li'l Spider Girl|Wasurenagumo
Паладин з далекого краю↑Saihate no Paladin|The Faraway Paladin|Paladin of the End, Ultimate Paladin|The Faraway Paladin|Saihate no Paladin
Паладин з далекого краю: Король іржавих гір↑Saihate no Paladin: Tetsusabi no Yama no Ou|The Faraway Paladin: The Lord of the Rust Mountains|Saihate no Paladin 2nd Season|The Faraway Paladin: The Lord of the Rust Mountains|Saihate no Paladin: Tetsusabi no Yama no Ou
Палка ніч із монахом↑Souryo to Majiwaru Shikiyoku no Yoru ni...|On a Lustful Night Mingling with a Priest|On a Lustful Night Mingling with a Priest|Souryo to Majiwaru Shikiyoku no Yoru ni...
Палкі бажання негідників↑Kuzu no Honkai|Scum's Wish|Scum's Wish|Kuzu no Honkai
Пан покоївка в гуртожитку богинь↑Megami-ryou no Ryoubo-kun.|Mother of the Goddess' Dormitory|Mother of the Goddess' Dormitory|Megami-ryou no Ryoubo-kun.
Панування семи магічних мечів↑Nanatsu no Maken ga Shihai suru|Reign of the Seven Spellblades|Nanatsuma|Reign of the Seven Spellblades|Nanatsu no Maken ga Shihai suru
Пані Каґуя – Перший поцілунок ніколи не закінчується↑Kaguya-sama wa Kokurasetai: First Kiss wa Owaranai|Kaguya-sama: Love is War - The First Kiss That Never Ends|Kaguya-sama: Love is War - The First Kiss That Never Ends|Kaguya-sama wa Kokurasetai: First Kiss wa Owaranai
Пані Кубо не дає мені бути невидимим↑久保さんは僕を許さない|Kubo Won't Let Me Be Invisible|Kubo-san wa Boku wo Yurusanai|Kubo-san Doesn't Leave Me Be (a Mob)
Паприка↑パプリカ|Paprika
Паприка↑パプリカ|Paprika
Паприка↑Paprika|Paprika|Paprika
Пара Зозуль↑Kakkou no Iinazuke|A Couple of Cuckoos|Cuckoo's Fiancee|A Couple of Cuckoos|Kakkou no Iinazuke
Парад Смерті / Смертельний бiльярд↑デス・パレード|Death Parade
Парад Смерті, Смертельний бiльярд↑デス・ビリヤード|Death Billiards|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012
Паразит↑Kiseijuu: Sei no Kakuritsu|Parasyte: The Maxim|Parasite, Parasitic Beasts, Parasyte|Parasyte: The Maxim|Kiseijuu: Sei no Kakuritsu
Парк західної брами Ікебукуро↑池袋ウエストゲートパーク|Ikebukuro West Gate Park|IWGP
Пастка брехні↑捏造トラップ―NTR―|Netsuzou Trap -NTR-
Патема догори дриґом↑サカサマのパテマ|Patema Inverted|Sakasama no Patema
Патема догори дриґом - початок нового дня↑サカサマのパテマ Beginning of the Day|Patema Inverted: Beginning of the Day
Патріот Моріарті↑Yuukoku no Moriarty|Moriarty the Patriot|Moriarty's Patriotism|Moriarty the Patriot|Yuukoku no Moriarty
Патріот Моріарті (Частина 2)↑Yuukoku no Moriarty Part 2|Moriarty the Patriot Part 2|Moriarty's Patriotism Part 2, Moriarty the Patriot 2|Moriarty the Patriot Part 2|Yuukoku no Moriarty Part 2
Певний Науковий Рейкотрон↑Toaru Kagaku no Railgun|A Certain Scientific Railgun|Toaru Kagaku no Choudenjihou|A Certain Scientific Railgun|Toaru Kagaku no Railgun
Певний магічний Індекс↑Toaru Majutsu no Index|A Certain Magical Index|Toaru Majutsu no Kinsho Mokuroku|A Certain Magical Index|Toaru Majutsu no Index
Певний магічний Індекс (3 сезон)↑とある魔術の禁書目録Ⅲ|A Certain Magical Index III|Toaru Majutsu no Index 3|Toaru Majutsu no Kinsho Mokuroku 3
Певний магічний Індекс (Сезон 2)↑Toaru Majutsu no Index II|A Certain Magical Index II|Toaru Majutsu no Index 2, Toaru Majutsu no Kinsho Mokuroku 2|A Certain Magical Index II|Toaru Majutsu no Index II
Певний магічний Індекс Фільм: Диво Ендіміона↑Toaru Majutsu no Index Movie: Endymion no Kiseki|A Certain Magical Index the Movie: The Miracle of Endymion|Gekijouban Toaru Majutsu no Kinsho Mokuroku|A Certain Magical Index the Movie: The Miracle of Endymion|Toaru Majutsu no Index Movie: Endymion no Kiseki
Певний науковий Акселератор↑Toaru Kagaku no Accelerator|A Certain Scientific Accelerator|To Aru Majutsu no Index Gaiden, Toaru Kagaku no Ippou Tsuukou|A Certain Scientific Accelerator|Toaru Kagaku no Accelerator
Певний науковий Рейкотрон 2↑とある科学の超電磁砲S|A Certain Scientific Railgun S|Toaru Kagaku no Railgun 2|Toaru Kagaku no Choudenjihou 2|A Certain Scientific Railgun 2
Пекельна дівчинка↑地獄少女|Hell Girl|Jigoku Shojo
Пеклорай / Пекельний рай↑Jigokuraku|Hell's Paradise|Paradition, Heavenhell|Hell's Paradise|Jigokuraku
Передісторія нашого кохання↑Yeon-ae Halujeon|A Day Before Us|A Day Before Us|Yeon-ae Halujeon
Перезапис↑リライト|Rewrite
Перезапис 2: Місяць і Земля↑Rewrite 2ndシーズン|Rewrite: Moon and Terra|Rewrite: Moon-hen / Terra-hen
Перезапуск Сакуради↑サクラダリセット|Sagrada Reset
Перезапуск нашого життя↑Bokutachi no Remake|Remake Our Life!|Bokurema|Remake Our Life!|Bokutachi no Remake
Перемикач↑スイッチ|Switch
Перемогти Пірата Ґандзака!↑ワンピース 倒せ！海賊ギャンザック|One Piece: Defeat the Pirate Ganzack!
Перероджений мудрецем в іншому світі↑Tensei Kenja no Isekai Life: Dai-2 no Shokugyou wo Ete, Sekai Saikyou ni Narimashita|My Isekai Life: I Gained a Second Character Class and Became the Strongest Sage in the World|Tensei Kenjya no Isekai Life|My Isekai Life: I Gained a Second Character Class and Became the Strongest Sage in the World|Tensei Kenja no Isekai Life: Dai-2 no Shokugyou wo Ete, Sekai Saikyou ni Narimashita
Переродження в майстриню меча з короля героя / Переродження Короля Героя у Майстриню Меча↑Eiyuuou, Bu wo Kiwameru Tame Tenseisu: Soshite, Sekai Saikyou no Minarai Kishi♀|Reborn to Master the Blade: From Hero-King to Extraordinary Squire ♀|Reborn to Master the Blade: From Hero-King to Extraordinary Squire ♀|Eiyuuou, Bu wo Kiwameru Tame Tenseisu: Soshite, Sekai Saikyou no Minarai Kishi♀
Переродження найсильнішого екзорциста в іншому світі↑Saikyou Onmyouji no Isekai Tenseiki|The Reincarnation of the Strongest Exorcist in Another World|The Reincarnation of the Strongest Onmyouji in Another World|The Reincarnation of the Strongest Exorcist in Another World|Saikyou Onmyouji no Isekai Tenseiki
Переродження у аристократа з унікальною навичкою оцінки↑Tensei Kizoku, Kantei Skill de Nariagaru|As a Reincarnated Aristocrat, I'll Use My Appraisal Skill to Rise in the World|Reincarnated as an Aristocrat with an Appraisal Skill|As a Reincarnated Aristocrat, I'll Use My Appraisal Skill to Rise in the World|Tensei Kizoku, Kantei Skill de Nariagaru
Переродження: Життя з нуля в іншому світі↑Re:Zero kara Hajimeru Isekai Seikatsu|Re:ZERO -Starting Life in Another World-|Re: Life in a different world from zero, ReZero|Re:ZERO -Starting Life in Another World-|Re:Zero kara Hajimeru Isekai Seikatsu
Переродження: Життя з нуля в іншому світі (сезон 2)↑Re:Zero kara Hajimeru Isekai Seikatsu 2nd Season|Re:ZERO -Starting Life in Another World- Season 2|Re: Life in a different world from zero 2nd Season, ReZero 2nd Season, Re:Zero - Starting Life in Another World 2|Re:ZERO -Starting Life in Another World- Season 2|Re:Zero kara Hajimeru Isekai Seikatsu 2nd Season
Переродження: Життя з нуля в іншому світі (сезон 2, частина 2)↑Re:Zero kara Hajimeru Isekai Seikatsu 2nd Season Part 2|Re:ZERO -Starting Life in Another World- Season 2 Part 2|Re: Life in a different world from zero 2nd Season, ReZero 2nd Season, Re:Zero - Starting Life in Another World 2|Re:ZERO -Starting Life in Another World- Season 2 Part 2|Re:Zero kara Hajimeru Isekai Seikatsu 2nd Season Part 2
Переродження: Монстр↑Re:Monster|ReMonster
Перехрестя↑クロスロード|Cross Road|Crossroad
Перехрестя Такано↑Takano Kousaten|Takano Intersection|Takano Intersection|Takano Kousaten
Персиковий хлопчик з іншого берега↑ピーチボーイリバーサイド|Peach Boy Riverside
Персона 3↑PERSONA3 THE MOVIE —#1 Spring of Birth—|Persona 3 the Movie: #1 Spring of Birth|Shin Megami Tensei: Persona 3|P3M
Персона 4↑ペルソナ4アニメーション|Persona 4 the Animation|P4A
Персона 5↑TVアニメ「ペルソナ５」|Persona 5 the Animation|P5A|Persona 5 the Anime
Персона 5: Порушники↑PERSONA5 the Animation -THE DAY BREAKERS-|Persona 5 the Animation -THE DAY BREAKERS-
Персона: душа трійці↑ペルソナ 〜トリニティ・ソウル〜|Persona: Trinity Soul
Перстень диявола↑戒魔人|The Devil Ring|Xue Mo Ren
Перший Слем Данк↑THE FIRST SLAM DUNK
Перший Слем Данк↑THE FIRST SLAM DUNK|The First Slam Dunk
Перший Слем Данк↑THE FIRST SLAM DUNK
Перший крок↑Hajime no Ippo|Fighting Spirit|The First Step, Hajime no Ippo: The Fighting|Fighting Spirit|Hajime no Ippo
Пес та ножиці↑Inu to Hasami wa Tsukaiyou|Dog & Scissors|InuHasa, Dog and Scissors|Dog & Scissors|Inu to Hasami wa Tsukaiyou
Пес і я: Таємна служба↑妖狐×僕SS|Inu X Boku Secret Service|Youko x Boku SS
Планетарій. Зоряна людина↑Planetarian: Hoshi no Hito|Planetarian: Storyteller of the Stars|Planetarian: Storyteller of the Stars|Planetarian: Hoshi no Hito
Планетарій. Мрія маленької зірки↑Planetarian: Hoshi no Hito|Planetarian: Storyteller of the Stars|Planetarian: Storyteller of the Stars|Planetarian: Hoshi no Hito
Планетарій. Мрія маленької зірки↑Planetarian: Hoshi no Hito|Planetarian: Storyteller of the Stars|Planetarian: Storyteller of the Stars|Planetarian: Hoshi no Hito
Планетарій. Мрія маленької зірки↑Planetarian: Chiisana Hoshi no Yume|Planetarian: The Reverie of a Little Planet|Planetarian: The Reverie of a Little Planet|Planetarian: Chiisana Hoshi no Yume
Планетарій. Снігова куля↑planetarian ~雪圏球[スノーグローブ]~|Planetarian: Snow Globe
Планетарій. Снігова куля↑planetarian ~雪圏球[スノーグローブ]~|Planetarian: Snow Globe|Planetarian: Snow Globe OVA
Пластикова сестричка↑＋チック姉さん|Plastic Neesan|+tic Nee-san|+tic Elder Sister|Plustic Neesan|Plastic Nee-san|Purasu Chikku Neesan|Plastic Elder Sister
Пластикова сестричка↑＋チック姉さん|Plastic Neesan|+tic Nee-san|+tic Elder Sister|Plustic Neesan|Plastic Nee-san|Purasu Chikku Neesan|Plastic Elder Sister
Пластикові спогади↑プラスティック・メモリーズ|Plastic Memories|Plamemo
Платинова межа↑プラチナエンド|Platinum End
Плач ягняти↑羊のうた|Hitsuji no Uta|Lament of the Lamb|Song Of Ram|Song of Sheep|Song of the Sheep|Sheep's Song
Плин часу - Станція Токіо↑時季（とき）は巡る～TOKYO STATION～|Passage of Time: Tokyo Station
Плин часу - Станція Токіо↑時季（とき）は巡る～TOKYO STATION～|Passage of Time: Tokyo Station|Toki wa Meguru: Tokyo Station
Плин часу ~ СТАНЦІЯ ТОКІО↑時季（とき）は巡る～TOKYO STATION～|Passage of Time: Tokyo Station
Плутон↑プルートウ|Pluto
Плід Еволюції: Не встиг я озирнутись, як моє життя змінилось↑Shinka no Mi: Shiranai Uchi ni Kachigumi Jinsei|The Fruit of Evolution: Before I Knew It, My Life Had It Made|The Evolution Fruit: Conquering Life Unknowingly|The Fruit of Evolution: Before I Knew It, My Life Had It Made|Shinka no Mi: Shiranai Uchi ni Kachigumi Jinsei
Плід Ґрісайї (1 сезон)↑Grisaia no Kajitsu|The Fruit of Grisaia|Le Fruit de la Grisaia|The Fruit of Grisaia|Grisaia no Kajitsu
По той бік скла↑グラスリップ|Glasslip
Побачення з Життям 5↑デート・ア・ライブⅤ|Date A Live V|Date A Live 5|Date A Live Fifth Season|DAL 5
Побачення з життям (1 сезон)↑デート・ア・ライブ|Date A Live
Побачення з життям (2 сезон)↑デート・ア・ライブⅡ|Date A Live II|Date A Live 2
Побачення з життям (3 сезон)↑Date A Live III|Date A Live III|Date A Live 3, Date A Live 3rd Season, DAL 3|Date A Live III
Побачення з життям (4 сезон)↑デート・ア・ライブⅣ|Date A Live IV|Date A Live 4|Date A Live Fourth Season|DAL 4
Побачення з кулею↑デート・ア・バレット デッド・オア・バレット|Date A Bullet: Dead or Bullet|Date A Live Fragment: Date A Bullet
Побачення з кулею: Частина 1 - Куля або смерть↑デート・ア・バレット デッド・オア・バレット|Date A Bullet: Dead or Bullet|Date A Live Fragment: Date A Bullet
Побачення з кулею: Частина 1 - Куля або смерть↑デート・ア・バレット デッド・オア・バレット|Date A Bullet: Dead or Bullet|Date A Live Fragment: Date A Bullet
Побачення з кулею: Частина 2 - Кошмар або королева↑デート・ア・バレット デッド・オア・バレット|Date A Bullet: Dead or Bullet|Date A Live Fragment: Date A Bullet
Побачення з кулею: Частина 2 - Кошмар або королева↑デート・ア・バレット ナイトメア・オア・クイーン|Date A Bullet: Nightmare or Queen
Побачення з кулею: Частина 2 - Кошмар або королева↑デート・ア・バレット ナイトメア・オア・クイーン|Date A Bullet: Nightmare or Queen
Повелитель↑オーバーロード|Overlord
Повелитель (Сезон 2)↑オーバーロードⅡ|Overlord II
Повелитель (Сезон 3)↑オーバーロードⅢ|Overlord III
Повелитель (Сезон 4)↑オーバーロード IV|Overlord IV
Повелитель звірів, вигнаний з паті героя, зустрів дівчину-кицьку з сильнішої раси↑Yuusha Party wo Tsuihou sareta Beast Tamer, Saikyoushu no Nekomimi Shoujo to Deau|Beast Tamer|The Beast Tamer Who Got Kicked Out From His Party Meets a Cat Girl From the Superior Race|Beast Tamer|Yuusha Party wo Tsuihou sareta Beast Tamer, Saikyoushu no Nekomimi Shoujo to Deau
Повелитель стріл та Діва Війни↑魔弾の王と戦姫 (ヴァナディース)|Lord Marksman and Vanadis|Madan no Ou to Senki|The King of the Magic Bullet and Vanadis
Повернення кота|Віддяка кота|Котяча вдячність|Кицина подяка↑Neko no Ongaeshi|The Cat Returns|The Cat's Repayment|The Cat Returns|Neko no Ongaeshi
Повернення кота|Віддяка кота|Котяча вдячність|Кицина подяка↑Neko no Ongaeshi|The Cat Returns|The Cat's Repayment|The Cat Returns|Neko no Ongaeshi
Повернення кота|Віддяка кота|Котяча вдячність|Кицина подяка↑Neko no Ongaeshi|The Cat Returns|The Cat's Repayment|The Cat Returns|Neko no Ongaeshi
Повернути твій голос↑Kimi no Koe wo Todoketai|Your Voice -KIMIKOE-|I Want to Deliver Your Voice|Your Voice -KIMIKOE-|Kimi no Koe wo Todoketai
Повзучий Хаос! Ньяруко↑這いよる!ニャルアニ リメンバー・マイ・ラブ(クラフト先生)|Haiyoru! Nyaruani: Remember My Mr. Lovecraft|Haiyoru! Nyaruani: Remember My Love(craft-sensei) Episode 12|Haiyore! Nyaruko-san|Haiyoru! Nyarl-ani: Remember My Love(craft-sensei) Episode 12
Повсякденне життя Безсмертного Короля↑仙王的日常生活|The Daily Life of the Immortal King|Xian Wang de Ri Chang Sheng Huo
Повсякденне життя агентів↑时光照相馆的日常|Link Click: The Daily Life in Lightime|Shiguang Dailiren Xiao Juchang|时光代理人小剧场|Link Click Mini Theater
Повсякденне життя безсмертного короля (Сезон 2)↑仙王的日常生活 第二季|The Daily Life of the Immortal King 2|Xian Wang de Richang Shenghuo Er|仙王的日常生活 贰
Повсякденне життя старшокласників↑Danshi Koukousei no Nichijou|Daily Lives of High School Boys|Daily Lives of High School Boys|Danshi Koukousei no Nichijou
Повсякденнощі↑Nichijou|Nichijou - My Ordinary Life|Everyday|Nichijou - My Ordinary Life|Nichijou
Повтор цілителя↑Kaifuku Jutsushi no Yarinaoshi|Redo of Healer|Kaiyari|Redo of Healer|Kaifuku Jutsushi no Yarinaoshi
Повільна петля↑スローループ|Slow Loop
Повість Зестірії: пришестя Пастиря↑Tales of Zestiria: Doushi no Yoake|Tales of Zestiria: Dawn of the Shepherd|Tales of Zestiria: Dawn of the Shepherd|Tales of Zestiria: Doushi no Yoake
Повість про Джюбея, ніндзя вітру↑獣兵衛忍風帖|Ninja Scroll|Wind Ninja Chronicles|Juubei Ninpucho
Повість про Кінець Світу (1 частина)↑Shuumatsu no Walküre|Record of Ragnarok|Shuumatsu no Valkyrie, Valkyrie of the End, Valkyrie Apocalypse|Record of Ragnarok|Shuumatsu no Walküre
Повість про Кінець Світу (2 частина)↑Shuumatsu no Walküre II|Record of Ragnarok II|Shuumatsu no Walküre 2nd Season, Record of Ragnarok 2nd Season, Shuumatsu no Valkyrie, Valkyrie of the End|Record of Ragnarok II|Shuumatsu no Walküre II
Повість про сім міст: Арктичний фронт↑七都市物語 ～北極海戦線～|Nana Toshi Monogatari: Hokkyokukai Sensen|Seven Cities Story: Arctic Front
Повість про Ґендзі↑源氏物語|Genji Monogatari|The Tale of Genji|Murasaki Shikibu's Tale of Genji
Повітряні Дракони↑Kuutei Dragons|Drifting Dragons|Airborne Dragons|Drifting Dragons|Kuutei Dragons
Поганий соратник для групи героя обрав спокійне життя в селі↑Shin no Nakama ja Nai to Yuusha no Party wo Oidasareta node, Henkyou de Slow Life suru Koto ni Shimashita|Banished From The Hero's Party, I Decided To Live A Quiet Life In The Countryside|Banished from the Hero's Party, I Decided to Live a Quiet Life in the Countryside, I Was Kicked out of the Hero's Party Because I Wasn't a True Companion so I Decided to Have a Slow Life at the Frontier|Banished From The Hero's Party, I Decided To Live A Quiet Life In The Countryside|Shin no Nakama ja Nai to Yuusha no Party wo Oidasareta node, Henkyou de Slow Life suru Koto ni Shimashita
Поганий соратник для групи героя обрав спокійне життя в селі 2↑Shin no Nakama ja Nai to Yuusha no Party wo Oidasareta node, Henkyou de Slow Life suru Koto ni Shimashita 2nd|Banished From The Hero's Party, I Decided To Live A Quiet Life In The Countryside Season 2|Banished from the Hero's Party, I Decided to Live a Quiet Life in the Countryside, I Was Kicked out of the Hero's Party Because I Wasn't a True Companion so I Decided to Have a Slow Life at the Frontier 2|Banished From The Hero's Party, I Decided To Live A Quiet Life In The Countryside Season 2|Shin no Nakama ja Nai to Yuusha no Party wo Oidasareta node, Henkyou de Slow Life suru Koto ni Shimashita 2nd
Погані дівчата Рокудо↑六道の悪女〈おんな〉たち|Rokudo's Bad Girls|Rokudou no Akujo-tachi
Поглинач богів↑GOD EATER|God Eater
Подвійний Джей↑だぶるじぇい|Double-J|Daburu Jei|Yuruani
Подорож Елейни / Мандрівна Відьма: Подорож Елайни↑Majo no Tabitabi|Wandering Witch: The Journey of Elaina|Wandering Witch: The Journey of Elaina|Majo no Tabitabi
Подорож Кіно. Чарівний світ (1 сезон)↑Kino no Tabi: The Beautiful World|Kino's Journey|Kino's Travels: The Beautiful World|Kino's Journey|Kino no Tabi: The Beautiful World
Подорож Кіно. Чарівний світ. Фільм другий - Країна хвороби. Для тебе↑キノの旅 -the Beautiful World- 病気の国 -For You-|Kino no Tabi: The Beautiful World - Byouki no Kuni - For You|Kino's Journey: The Beautiful World - The Land of Sickness: For You|Land of Illness|Land of Disease
Подорож Кіно. Чарівний світ. Фільм другий - Країна хвороби. Для тебе↑キノの旅 -the Beautiful World- 病気の国 -For You-|Kino no Tabi: The Beautiful World - Byouki no Kuni - For You|Kino's Journey: The Beautiful World - The Land of Sickness: For You|Land of Illness|Land of Disease|Gekijô ban kino no tabi: Byôki no kuni - For you
Подорож Кіно. Чарівний світ. Фільм перший - Життя триває↑劇場版 キノの旅 -the Beautiful World- 何かをするために -life goes on.|Kino no Tabi: The Beautiful World - Nanika wo Suru Tame ni - Life Goes On.|Kino no Tabi: the Beautiful World - Life Goes On|Kino's Journey Movie
Пожежник Дайґо. Помаранчевий рятувальник↑Megumi no Daigo: Kyuukoku no Orange|Firefighter Daigo: Rescuer in Orange|Firefighter Daigo: Rescuer in Orange|Megumi no Daigo: Kyuukoku no Orange
Пожирач душ↑ソウルイーター|Soul Eater
Пожирач зірок↑Tunshi Xingkong|Swallowed Star|Swallowed Star|Tunshi Xingkong
Пожирач зірок (2 сезон)↑Tunshi Xingkong 2nd Season|Swallowed Star 2nd Season|吞噬星空 壮志凌云|Swallowed Star 2nd Season|Tunshi Xingkong 2nd Season
Пожирачі духів: Витоки↑喰霊–零–|Ga-Rei-Zero|Garei: Zero
Поза очі↑敲敲|Out of Sight|OOS
Позашкільний Ханако↑Houkago Shounen Hanako-kun|After-School Hanako-kun|After-School Hanako-kun|Houkago Shounen Hanako-kun
Позичайка Аріетті|Арієтті з країни ліліпутів↑借りぐらしのアリエッティ|The Secret World of Arrietty|Karigurashi no Arrietti|The Borrower Arrietty
Позичайка Аріетті|Арієтті з країни ліліпутів|Позичайка Аріетті / Арієтті з країни ліліпутів↑借りぐらしのアリエッティ|The Secret World of Arrietty|Karigurashi no Arrietti|The Borrower Arrietty|The Secret World of Arrietty / Kari-gurashi no Arietti
Позичайка Аріетті|Арієтті з країни ліліпутів|Позичайка Аріетті / Арієтті з країни ліліпутів↑借りぐらしのアリエッティ|The Secret World of Arrietty|Karigurashi no Arrietti|The Borrower Arrietty
Покемон (Фільм 5): Герої Латіос і Латіас↑ポケットモンスター 水の都の護神 ラティアスとラティオス|Pokémon Heroes|Gekijouban Pocket Monsters: Mizu no Miyako Mamorigami Latias to Latios|Pokemon Movie 5
Покемон (фільм 1): М'юдва завдає удар у відповідь↑ポケットモンスター ミュウツーの逆襲|Pokémon: The First Movie - Mewtwo Strikes Back|Gekijouban Pocket Monsters: Mewtwo Strikes Back|Pokémon Movie 1|Pokémon: The Origin of Mewtwo|Pokémon: The First Movie Kanzenban|Pokémon: The First Movie Complete Version
Покемон (фільм): Джирачі - виконувач бажань↑ポケットモンスター・アドバンスジェネレーション 七夜の願い星 ジラーチ|Pokémon: Jirachi — Wish Maker|Gekijouban Pocket Monsters Advanced Generation: Nana-Yo no Negai Boshi Jiraachi|Pokemon Advanced Generation: Nanayo no Negaiboshi Jirachi
Покемон 01: М'юту завдає удару у відповідь↑ポケットモンスター ミュウツーの逆襲|Pokémon: The First Movie - Mewtwo Strikes Back|Gekijouban Pocket Monsters: Mewtwo Strikes Back|Pokémon Movie 1|Pokémon: The Origin of Mewtwo|Pokémon: The First Movie Kanzenban|Pokémon: The First Movie Complete Version
Покемон 6: Джирачі - виконавець бажань↑ポケットモンスター・アドバンスジェネレーション 七夜の願い星 ジラーチ|Pokémon: Jirachi — Wish Maker|Gekijouban Pocket Monsters Advanced Generation: Nana-Yo no Negai Boshi Jiraachi|Pokemon Advanced Generation: Nanayo no Negaiboshi Jirachi|Pokemon: Jirachi Wish Maker
Покемон назавжди: Селебі - голос лісу / Покемон 4↑ポケットモンスター セレビィ 時を越えた遭遇（であい）|Pokémon 4Ever|Gekijouban Pocket Monsters: Serebii Toki wo Koeta Deai|Celebi: A Timeless Encounter|Pokémon Movie 4|Celebi: Voice of the Forest
Покемон назавжди: Селебі — голос лісу↑ポケットモンスター セレビィ 時を越えた遭遇（であい）|Pokémon 4Ever|Gekijouban Pocket Monsters: Serebii Toki wo Koeta Deai|Celebi: A Timeless Encounter|Pokémon Movie 4|Celebi: Voice of the Forest|Pokemon 4Ever
Покемон: Герої Латіос і Латіас↑ポケットモンスター 水の都の護神 ラティアスとラティオス|Pokémon Heroes|Gekijouban Pocket Monsters: Mizu no Miyako Mamorigami Latias to Latios|Pokemon Movie 5|Pokemon Heroes
Покемон: Легенда грому↑Pokemon Crystal: Raikou Ikazuchi no Densetsu|The Legend of Thunder!|Pocket Monsters Crystal: Raikou - Legend of Thunder|The Legend of Thunder!|Pokemon Crystal: Raikou Ikazuchi no Densetsu
Покемон: М'юту повертається↑Pokemon: Mewtwo! Ware wa Koko ni Ari|Pokémon: Mewtwo Returns|Pocket Monsters: Myuutsu! I Exist Here|Pokémon: Mewtwo Returns|Pokemon: Mewtwo! Ware wa Koko ni Ari
Покемон: Повернення М'юту↑ポケットモンスター ミュウツー! 我ハココニ在リ|Pokémon: Mewtwo Returns|Pocket Monsters: Myuutsu! I Exist Here
Покемон: Повернення М'юту↑ポケットモンスター ミュウツー! 我ハココニ在リ|Pokémon: Mewtwo Returns|Pocket Monsters: Myuutsu! I Exist Here|Pokemon: Mewtwo Returns
Покемон: Я обираю тебе!↑Pokemon Movie 20: Kimi ni Kimeta!|Pokémon the Movie: I Choose You!|Pokemon Movie 20|Pokémon the Movie: I Choose You!|Pokemon Movie 20: Kimi ni Kimeta!
Покинуте кроленя↑うさぎドロップ|Bunny Drop|Usagi Drop
Поклик ночі↑Yofukashi no Uta|Call of the Night|Call of the Night|Yofukashi no Uta
Полум'яні вогнеборці↑Enen no Shouboutai|Fire Force|Fire Brigade of Flames|Fire Force|Enen no Shouboutai
Полум'яні вогнеборці (сезон 2)↑Enen no Shouboutai: Ni no Shou|Fire Force Season 2|Enen no Shouboutai 2nd Season, Fire Force 2nd Season|Fire Force Season 2|Enen no Shouboutai: Ni no Shou
Полум’яний лабіринт↑Honoo no Labyrinth|Labyrinth Of Flames|Labyrinth Of Flames|Honoo no Labyrinth
Полювання короля демонів на свою дружину↑Xie Wang Zhui Qi|The Demonic King Who Chases His Wife|The Demonic King Who Chases His Wife|Xie Wang Zhui Qi
Поліана↑愛少女ポリアンナ物語|Ai Shoujo Pollyanna Story|Sekai Meisaku Gekijou|Story of Pollyanna|Girl of Love|Ai Shoujo Pollyanna Monogatari
Політ відьми↑ふらいんぐうぃっち|Flying Witch
Поліфоніка↑Shinkyoku Soukai Polyphonica|Polyphonica|Polyphonica|Shinkyoku Soukai Polyphonica
Поліфоніка Crimson S↑神曲奏界ポリフォニカcrimsonS|Polyphonica Crimson S
Поліцейське ремесло↑COP CRAFT [コップクラフト]|Cop Craft
Пом Поко / Війна тануки в періоди Хейсей і Помпоко↑Heisei Tanuki Gassen Ponpoko|Pom Poko|Pom Poko|Heisei Tanuki Gassen Ponpoko
Пом Поко / Війна тануки в періоди Хейсей і Помпоко↑Heisei Tanuki Gassen Ponpoko|Pom Poko|Pom Poko|Heisei Tanuki Gassen Ponpoko
Помаранч↑惡果|Orange
Помпо: Кіноман↑Eiga Daisuki Pompo-san|Pompo: The Cinéphile|Pompo: The Cinéphile|Eiga Daisuki Pompo-san
Помпоко: Боротьба єнотів в епоху Хейсей↑Heisei Tanuki Gassen Ponpoko|Pom Poko|Pom Poko|Heisei Tanuki Gassen Ponpoko
Помста Масамуне↑政宗くんのリベンジ|Masamune-kun's Revenge
Помста Масамуне 2↑Masamune-kun no Revenge R|Masamune-kun's Revenge R|Masamune-kun's Revenge R|Masamune-kun no Revenge R
Поневіряння мага Орфена↑Majutsushi Orphen Hagure Tabi|Sorcerous Stabber Orphen|Sorcerous Stabber Orphen|Majutsushi Orphen Hagure Tabi
Поневіряння мага Орфена 3↑魔術士オーフェンはぐれ旅 アーバンラマ編|Sorcerous Stabber Orphen -Chaos in Urbanrama-|Majutsushi Orphen Hagure Tabi 3rd Season|Sorcerous Stabber Orphen 3rd Season
Поневіряння мага Орфена: Розділ про Кімлак (2 сезон)↑Majutsushi Orphen Hagure Tabi: Kimluck-hen|Sorcerous Stabber Orphen: Battle of Kimluck|Majutsushi Orphen Hagure Tabi 2nd Season, Sorcerous Stabber Orphen 2nd Season, Sorcerous Stabber Orphen: Kimluck Arc|Sorcerous Stabber Orphen: Battle of Kimluck|Majutsushi Orphen Hagure Tabi: Kimluck-hen
Поньо на кручі↑Gake no Ue no Ponyo|Ponyo|Ponyo on the Cliff by the Sea|Ponyo|Gake no Ue no Ponyo
Портрет крихітки Козетти↑Cossette no Shouzou|Le Portrait de Petit Cossette|Le Portrait de Petite Cossette|Le Portrait de Petit Cossette|Cossette no Shouzou
Постапокаліптична шьоджьо-мандрівка, Постапокаліптичне шьоджьо-походження↑Shoujo Shuumatsu Ryokou|Girls' Last Tour|The End Girl Trip|Girls' Last Tour|Shoujo Shuumatsu Ryokou
Постарайся, Докі↑がんばれ同期ちゃん|Ganbare Douki-chan|Do Your Best|Douki-chan|Senpai is Mine
Поступове Мистецтво меча онлайн. Арія беззоряної ночі↑劇場版 ソードアート・オンライン プログレッシブ 星なき夜のアリア|Sword Art Online the Movie: Progressive - Aria of a Starless Night|SAO Progressive Movie|Aria in the Starless Night|Hoshinaki Yoru no Aria|Sword Art Online the Movie -Progressive- Aria of a Starless Night
Посібник принца-генія з виводу країни з боргів↑Tensai Ouji no Akaji Kokka Saisei Jutsu|The Genius Prince's Guide to Raising a Nation Out of Debt|The Genius Prince's Guide to Raising a Nation Out of Debt|Tensai Ouji no Akaji Kokka Saisei Jutsu
Поцілуй його, а не мене!↑Watashi ga Motete Dousunda|Kiss Him, Not Me!|Kiss Him, Not Me!|Watashi ga Motete Dousunda
Поцілуй мене↑キッスは瞳にして|Kiss wa Hitomi ni Shite|Kiss me on the Apple of my Eye|Kiss wa me ni shite
Поцілунок сестер↑キスシス|Kiss x Sis (TV)|Kiss x Sis (2010)|Kissxsis
Початок кінця↑果ての一閃 EPISODE ZERO|Dawn of the Eclipse: Episode Zero
Почесна учениця школи магії↑Mahouka Koukou no Yuutousei|The Honor Student at Magic High School|The Honor Student at Magic High School|Mahouka Koukou no Yuutousei
Пошепки заспіваю тобі про кохання↑Sasayaku You ni Koi wo Utau|Whisper Me a Love Song|Whispering You a Love Song, Sasakoi|Whisper Me a Love Song|Sasayaku You ni Koi wo Utau
Пошепки заспіваю тобі про кохання↑Sasayaku You ni Koi wo Utau|Whisper Me a Love Song|Whispering You a Love Song, Sasakoi|Whisper Me a Love Song|Sasayaku You ni Koi wo Utau
Пощадіть мене Величний Пане 2↑Da Wang Rao Ming 2|Spare Me, Great Lord! 2nd Season|Spare Me, Great Lord! 2nd Season|Da Wang Rao Ming 2
Прагнення до вершини 2! Diebuster↑Top wo Nerae 2! Diebuster|Gunbuster 2|Aim for the Top! 2, DieBuster|Gunbuster 2|Top wo Nerae 2! Diebuster
Прагнення до вершини! Gunbuster↑Top wo Nerae! Gunbuster|Gunbuster|Top wo Nerae!, Aim for the Top!|Gunbuster|Top wo Nerae! Gunbuster
Президент студради — покоївка!↑Kaichou wa Maid-sama!|Maid Sama!|Class President is a Maid!|Maid Sama!|Kaichou wa Maid-sama!
Приваблива дівчина↑ハンサムな彼女|Handsome Girl|Handsome na Kanojo
Приваблива дівчина↑ハンサムな彼女|Handsome Girl|Handsome na Kanojo|Handsome Girl OVA / Handsome na Kanojo
Приватні детективи Футо↑風都探偵|Fuuto PI
Привид в латах↑GHOST IN THE SHELL（攻殻機動隊）|Ghost in the Shell
Привид в латах / Привид у броні↑GHOST IN THE SHELL（攻殻機動隊）|Ghost in the Shell
Привид в латах 2. Невинність↑イノセンス|Ghost in the Shell 2: Innocence|Koukaku Kidoutai 2: Innocence
Привид в латах: Синдром самітника (1 сезон)↑Koukaku Kidoutai: Stand Alone Complex|Ghost in the Shell: Stand Alone Complex|Ghost in the Shell SAC, Ghost in the Shell: Stand Alone Complex|Ghost in the Shell: Stand Alone Complex|Koukaku Kidoutai: Stand Alone Complex
Привид в латах: Синдром самітника (2 сезон)↑Koukaku Kidoutai: Stand Alone Complex 2nd GIG|Ghost in the Shell: Stand Alone Complex 2nd GIG|Ghost In The Shell S.A.C. 2nd GIG|Ghost in the Shell: Stand Alone Complex 2nd GIG|Koukaku Kidoutai: Stand Alone Complex 2nd GIG
Привіт, світе↑ハロー・ワールド|Hello World
Привіт, світе↑ハロー・ワールド|Hello World
Привіт, світе↑ハロー・ワールド|Hello World
Привіт, сестричко↑お姉ちゃんが来た|Oneechan ga Kita|My Sister Came|Onee-chan
Пригоди Діґімонів: Наша воєнна гра↑Digimon Adventure: Bokura no War Game!|Digimon: The Movie|Digimon: Our War Game!, Digimon: Children's War Game!|Digimon: The Movie|Digimon Adventure: Bokura no War Game!
Пригоди Діґімонів: Наша воєнна гра!↑Digimon Adventure: Bokura no War Game!|Digimon: The Movie|Digimon: Our War Game!, Digimon: Children's War Game!|Digimon: The Movie|Digimon Adventure: Bokura no War Game!
Пригоди Муромі-сан↑Namiuchigiwa no Muromi-san|Muromi-san|Muromi-san|Namiuchigiwa no Muromi-san
Пригоди аристократа в іншому світі↑Tensei Kizoku no Isekai Boukenroku: Jichou wo Shiranai Kamigami no Shito|The Aristocrat's Otherworldly Adventure: Serving Gods Who Go Too Far|Chronicles of an Aristocrat Reborn in Another World: The Apostle of the Gods Who Know No Self-Restraint|The Aristocrat's Otherworldly Adventure: Serving Gods Who Go Too Far|Tensei Kizoku no Isekai Boukenroku: Jichou wo Shiranai Kamigami no Shito
Пригоди дігімонів (2 сезон) / Пригоди діґімонів (2 сезон)↑Digimon Adventure 02|Digimon Adventure 02|Digimon Adventure Zero Two, Digimon: Digital Monsters 02|Digimon Adventure 02
Пригоди діґімонів↑Digimon Adventure|Digimon: Digital Monsters|Digimon Adventure 01|Digimon: Digital Monsters|Digimon Adventure
Пригоди діґімонів: Остання еволюція↑Digimon Adventure: Last Evolution Kizuna|Digimon Adventure: Last Evolution Kizuna|Digimon Adventure: Last Evolution Kizuna
Пригоди діґімонів: Остання еволюція↑Digimon Adventure: Last Evolution Kizuna|Digimon Adventure: Last Evolution Kizuna|Digimon Adventure: Last Evolution Kizuna
Прикордонна війна↑Kyoukai Senki|AMAIM Warrior at the Borderline|AMAIM Warrior at the Borderline|Kyoukai Senki
Прикрась прощальний ранок квітами надії↑さよならの朝に約束の花をかざろう|Maquia: When the Promised Flower Blooms|Let's Decorate the Promised Flowers in the Morning of Farewells|SayoAsa
Прикрась прощальний ранок квітами надії↑Sayonara no Asa ni Yakusoku no Hana wo Kazarou|Maquia: When the Promised Flower Blooms|Let's Decorate the Promised Flowers in the Morning of Farewells, SayoAsa|Maquia: When the Promised Flower Blooms|Sayonara no Asa ni Yakusoku no Hana wo Kazarou
Прикрась прощальний ранок квітами надії↑Sayonara no Asa ni Yakusoku no Hana wo Kazarou|Maquia: When the Promised Flower Blooms|Let's Decorate the Promised Flowers in the Morning of Farewells, SayoAsa|Maquia: When the Promised Flower Blooms|Sayonara no Asa ni Yakusoku no Hana wo Kazarou
Прикрощі замкненої в собі принцеси вампірів↑Hikikomari Kyuuketsuki no Monmon|The Vexations of a Shut-In Vampire Princess|The Shut-In Vampire Princess' Worries|The Vexations of a Shut-In Vampire Princess|Hikikomari Kyuuketsuki no Monmon
Прима-лялька↑プリマドール|Prima Doll
Примара в обладунках: Автономний комплекс↑攻殻機動隊 STAND ALONE COMPLEX Solid State Society|Ghost in the Shell: Stand Alone Complex - Solid State Society|GitS SAC SSS|GitS: SAC 3|gits sac3|gitssac3|sac3|sss|Ghost in the Shell S.A.C. Solid State Society
Примарний світ безмежжя барв↑無彩限のファントム・ワールド|Myriad Colors Phantom World|Musaigen no Phantom World
Примхи помаранчевої вулиці↑きまぐれオレンジ☆ロード|Kimagure Orange Road|Kimagure Orange Road TV|Capricious Orange Road
Принц Страйду↑プリンス・オブ・ストライド　オルタナティブ|Prince of Stride: Alternative|PuriSuto
Принцеса Арета↑アリーテ姫|Princess Arete|Arite Hime|The Adventure of Princess Arete|Arete-hime
Принцеса Медуза↑海月姫|Princess Jellyfish|Kuragehime
Принцеса Мононоке↑もののけ姫|Princess Mononoke|Mononoke Hime
Принцеса Монстрів↑怪物王女|Princess Resurrection|Kaibutsu Ohjo|Monster Princess
Принцеса Труп: Червона↑屍姫 赫|Corpse Princess: Aka|Shikabane Hime Aka
Принцеса Труп: Чорна↑Shikabane Hime: Kuro|Corpse Princess: Kuro|Shikabane Hime Second Season|Corpse Princess: Kuro|Shikabane Hime: Kuro
Принцеса Тютю↑プリンセスチュチュ|Princess Tutu
Принцеса вампір Мію↑吸血姫美夕|Vampire Princess Miyu|Kyuuketsu Hime Miyu|Kyuuketsuki Miyu
Принцеса головна↑プリンセス・プリンシパル|Princess Principal
Принцеса піратів Фена↑Kaizoku Oujo|Fena: Pirate Princess|Fena: Pirate Princess|Kaizoku Oujo
Принцесо, час для тортур↑姫様“拷問”の時間です|'Tis Time for "Torture," Princess|It's Time for "Interrogation"|Princess!|Hime-sama "Goumon" no Jikan desu
Прискорений світ↑アクセル・ワールド|Accel World|Accelerated World
Пристойний заклад↑注文の多い料理店|Chuumon no Ooi Ryouriten (1993)|The Restaurant of Many Orders|A Well-Ordered Restaurant
Пристойний заклад↑注文の多い料理店|Chuumon no Ooi Ryouriten (1993)|The Restaurant of Many Orders|A Well-Ordered Restaurant|The Restaurant of Many Orders / Chuumon no Ooi Ryoriten
Прихисток↑シェルター|Shelter
Прихисток заблукалих↑Mayoiga|The Lost Village|The Lost Village|Mayoiga
Прихисток янгола↑天使禁猟区|Angel Sanctuary
Приховані речі↑かくしごと|Kakushigoto|Hidden Things|Kakushigoto: My Dad's Secret Ambition
Пришелепкувата Подружка↑Denpa-teki na Kanojo|Electromagnetic Girlfriend|The Radio Wave-Like Girlfriend|Electromagnetic Girlfriend|Denpa-teki na Kanojo
Приємно познайомитись, Бог (1 сезон)↑Kamisama Hajimemashita|Kamisama Kiss|Kamisama Kiss|Kamisama Hajimemashita
Приємно познайомитись, Бог (2 сезон)↑Kamisama Hajimemashita◎|Kamisama Kiss Season 2|Kamisama Hajimemashita 2nd Season, Kami-sama Hajimemashita 2nd Season, Kamisama Kiss 2nd Season|Kamisama Kiss Season 2|Kamisama Hajimemashita◎
Приємно познайомитись, Бог: Розділ про минуле↑Kamisama Hajimemashita: Kako-hen|Kamisama Hajimemashita: Kako-hen|Kamisama Hajimemashita: Kako-hen
Про моє переродження в слиз: Зв'язок Червоного Лотоса↑Tensei shitara Slime Datta Ken Movie: Guren no Kizuna-hen|That Time I Got Reincarnated as a Slime: The Movie - Scarlet Bond|TenSura, That Time I Got Reincarnated as a Slime Movie|That Time I Got Reincarnated as a Slime: The Movie - Scarlet Bond|Tensei shitara Slime Datta Ken Movie: Guren no Kizuna-hen
Про моє переродження в слиз: Королівство Колеус↑Tensei shitara Slime Datta Ken: Coleus no Yume|That Time I Got Reincarnated as a Slime: Visions of Coleus|That Time I Got Reincarnated as a Slime: Visions of Coleus|Tensei shitara Slime Datta Ken: Coleus no Yume
Про моє переродження у Сьомого принца↑Tensei shitara Dainana Ouji Datta node, Kimama ni Majutsu wo Kiwamemasu|I Was Reincarnated as the 7th Prince so I Can Take My Time Perfecting My Magical Ability|I Was Reincarnated as the 7th Prince, so I Will Perfect My Magic as I Please|I Was Reincarnated as the 7th Prince so I Can Take My Time Perfecting My Magical Ability|Tensei shitara Dainana Ouji Datta node, Kimama ni Majutsu wo Kiwamemasu
Провокаторка Такаґі↑Karakai Jouzu no Takagi-san|Teasing Master Takagi-san|Skilled Teaser Takagi-san|Teasing Master Takagi-san|Karakai Jouzu no Takagi-san
Провокаторка Такаґі (сезон 2)↑Karakai Jouzu no Takagi-san 2|Teasing Master Takagi-san 2|Skilled Teaser Takagi-san 2nd Season, Karakai Jouzu no Takagi-san Second Season|Teasing Master Takagi-san 2|Karakai Jouzu no Takagi-san 2
Провокаторка Такаґі 3↑からかい上手の高木さん3|Teasing Master Takagi-san 3|Skilled Teaser Takagi-san 3rd Season|Karakai Jouzu no Takagi-san Third Season
Провокаторка Такаґі: Фільм↑Karakai Jouzu no Takagi-san Movie|Teasing Master Takagi-san: The Movie|Teasing Master Takagi-san: The Movie|Karakai Jouzu no Takagi-san Movie
Прогресивна панянка Фільм 1: Беніо, 17-річна квітка↑Haikara-san ga Tooru Movie 1: Benio, Hana no 17-sai|Haikara-san: Here Comes Miss Modern|Gekijouban Haikara-san ga Tooru Zenpen, Smart-san, Mademoiselle Anne, There Goes the Modern Girl, Here Comes a Dandy|Haikara-san: Here Comes Miss Modern|Haikara-san ga Tooru Movie 1: Benio, Hana no 17-sai
Прогресивна панянка Фільм 2: Великий роман токійської квітки↑Haikara-san ga Tooru Movie 2: Hana no Tokyo Dai Roman|Haikara-san: Here Comes Miss Modern Part 2|Gekijouban Haikara-san ga Tooru Kouhen, Smart-san, Mademoiselle Anne, There Goes the Modern Girl, Here Comes Miss Modern, Here Comes a Dandy|Haikara-san: Here Comes Miss Modern Part 2|Haikara-san ga Tooru Movie 2: Hana no Tokyo Dai Roman
Прогресивна панянка. Беніо — 17-річна квіточка. Фільм 1↑Haikara-san ga Tooru Movie 1: Benio, Hana no 17-sai|Haikara-san: Here Comes Miss Modern|Gekijouban Haikara-san ga Tooru Zenpen, Smart-san, Mademoiselle Anne, There Goes the Modern Girl, Here Comes a Dandy|Haikara-san: Here Comes Miss Modern|Haikara-san ga Tooru Movie 1: Benio, Hana no 17-sai
Прогулянка в гори↑Yama no Susume|Encouragement of Climb|Encouragement of Climb|Yama no Susume
Прогулянки маленької акули↑おでかけ子ザメ|Odekake Kozame|Little Shark's Outings|Outgoing Baby Shark|Little Shark's Day Out
Проект К: Зниклі Королі↑K MISSING KINGS|K: Missing Kings|K (Movie)|K-Project Movie|K-Project Sequel
Пройдисвіти↑HELLSING THE DAWN|Hellsing: The Dawn|Hellsing: The Dawn - A supplementary of HELLSING|Hellsing OVA Specials|Hellsing Ultimate Specials|Drifters
Прокачуючи свої фермерські навички я, якимсь чином, став сильнішим↑Noumin Kanren no Skill bakka Agetetara Nazeka Tsuyoku Natta.|I've Somehow Gotten Stronger When I Improved My Farm-Related Skills|I've Somehow Gotten Stronger When I Improved My Farm-Related Skills|Noumin Kanren no Skill bakka Agetetara Nazeka Tsuyoku Natta.
Промари↑PROMARE（プロメア）|Promare
Промари↑PROMARE（プロメア）|Promare
Промари↑PROMARE（プロメア）|Promare
Просто так!↑Just Because!
Прошу, врятуй мою землю↑Boku no Chikyuu wo Mamotte|Please Save My Earth|Bokutama, PSME|Please Save My Earth|Boku no Chikyuu wo Mamotte
Прощавай, Відчай-сенсей↑さよなら絶望先生|Sayonara, Zetsubou-Sensei|Sayonara Zetsubo Sensei|Goodbye Teacher Despair|SZS
Прощавай, мій любимий Крамер↑Sayonara Watashi no Cramer|Farewell, My Dear Cramer|Good-bye, Cramer|Farewell, My Dear Cramer|Sayonara Watashi no Cramer
Проєкт біла кішка: Нульова хроніка↑白猫プロジェクトZERO CHRONICLE|Shironeko Project ZERO CHRONICLE|White Cat Project|Rune Story
Пріоритет диво-яйця↑ワンダーエッグ・プライオリティ|Wonder Egg Priority
Пси: Безхатні, що виють у темряві↑ドッグズ／バレッツ＆カーネイジ|Dogs: Bullets & Carnage|DOGS|Dogs: Bullets and Carnage|Dogs: Stray Dogs Howling in the Dark
Психопаспорт (1 сезон)↑サイコパス|Psycho-Pass|Psychopath
Психопаспорт (2 сезон)↑PSYCHO-PASS サイコパス 2|Psycho-Pass 2|Psycho-Pass Second Season|Psychopath 2nd Season
Психопаспорт (3 сезон)↑PSYCHO-PASS サイコパス 3|Psycho-Pass 3
Психопаспорт. Грішники системи↑Psycho-Pass: Sinners of the System Case.1 - Tsumi to Batsu|Psycho-Pass: Sinners of the System Case.1 - Crime and Punishment|Psycho-Pass SS Case 1: Tsumi to Batsu|Psycho-Pass: Sinners of the System Case.1 - Crime and Punishment|Psycho-Pass: Sinners of the System Case.1 - Tsumi to Batsu
Психопаспорт. Фільм↑劇場版 サイコパス|Psycho-Pass: The Movie|Psychopath Movie
Психопаспорт. Фільм↑Psycho-Pass Movie|Psycho-Pass: The Movie|Psychopath Movie|Psycho-Pass: The Movie|Psycho-Pass Movie
Пташина пісня↑Tori no Uta|Bird's Song|Bird's Poem|Bird's Song|Tori no Uta
Пуні Пуні Поемі↑ぷにぷに☆ぽえみぃ|Puni Puni Poemy
Пупіпо↑プピポー！|Pupipo!|Pupipoo!
Пустельна ескадрилья Котобукі↑Kouya no Kotobuki Hikoutai|The Magnificent Kotobuki|The Kotobuki Squadron in the Wilderness|The Magnificent Kotobuki|Kouya no Kotobuki Hikoutai
Пустельний нікчема↑砂ぼうず|Desert Punk|Sunabozu
Під мостом над Аракавою↑荒川アンダー ザ ブリッジ|Arakawa Under the Bridge
Під мостом над Аракавою (Сезон 2)↑荒川アンダー ザブリッジ×ブリッジ|Arakawa Under the Bridge x Bridge|Arakawa Under the Bridge*2|Arakawa Under the Bridge x2|Arakawa Under the Bridge 2nd season
Піймай свою хвилю↑Kimi to, Nami ni Noretara|Ride Your Wave|Ride Your Wave|Kimi to, Nami ni Noretara
Піймай свою хвилю↑Kimi to, Nami ni Noretara|Ride Your Wave|Ride Your Wave|Kimi to, Nami ni Noretara
Піймай свою хвилю↑Kimi to, Nami ni Noretara|Ride Your Wave|Ride Your Wave|Kimi to, Nami ni Noretara
Пікнік у Потойбіччі↑Urasekai Picnic|Otherside Picnic|Otherside Picnic|Urasekai Picnic
Пінг-понг↑ピンポン THE ANIMATION|Ping Pong the Animation|PPTA
Пірати «Чорної Лагуни» (1 сезон)↑Black Lagoon|Black Lagoon|Black Lagoon
Пірати «Чорної Лагуни» (ТБ-2)↑Black Lagoon: The Second Barrage|Black Lagoon: The Second Barrage|Black Lagoon 2nd Season, Black Lagoon Second Season|Black Lagoon: The Second Barrage
Пісня серця↑Kokoro ga Sakebitagatterunda.|The Anthem of the Heart|Kokosake|The Anthem of the Heart|Kokoro ga Sakebitagatterunda.
Пітер Ґрілл та час філософа↑Peter Grill to Kenja no Jikan|Peter Grill and the Philosopher's Time|Peter Grill and the Philosopher's Time|Peter Grill to Kenja no Jikan
Пітьма всередині мене / Небезпека в серці↑Boku no Kokoro no Yabai Yatsu|The Dangers in My Heart|Bokuyaba|The Dangers in My Heart|Boku no Kokoro no Yabai Yatsu
Пітьма всередині мене 2↑Boku no Kokoro no Yabai Yatsu 2nd Season|The Dangers in My Heart Season 2|Bokuyaba|The Dangers in My Heart Season 2|Boku no Kokoro no Yabai Yatsu 2nd Season
Піщана Країна↑SAND LAND: THE SERIES|Sand Land: The Series
РПГ на всі часи (1 сезон)↑戦勇。|Senyuu.|Senyu
РПГ на всі часи (2 сезон)↑戦勇。2|Senyuu. 2|Senyu. 2
РаКсефон↑ラーゼフォン|RahXephon
Раб спеціального призначення↑Mato Seihei no Slave|Chained Soldier|Slave of the Magic Capital's Elite Troops, Mabotai|Chained Soldier|Mato Seihei no Slave
Радіант↑ラディアン|Radiant
Радіосигнал до дивачки↑Denpa Onna to Seishun Otoko|Ground Control to Psychoelectric Girl|Electromagnetic Wave Woman and Adolescent Man|Ground Control to Psychoelectric Girl|Denpa Onna to Seishun Otoko
Раеліана: Наречена герцога за контрактом↑Kanojo ga Koushaku-tei ni Itta Riyuu|Why Raeliana Ended up at the Duke's Mansion|Geunyeoga Gongjagjeolo Gaya Haessdeon Sajeong, 그녀가 공작저로 가야 했던 사정|Why Raeliana Ended up at the Duke's Mansion|Kanojo ga Koushaku-tei ni Itta Riyuu
Рай Ґрісайї↑Grisaia no Rakuen|The Eden of Grisaia|Le Eden de la Grisaia|The Eden of Grisaia|Grisaia no Rakuen
Райдужні дні↑虹色デイズ|Rainbow Days|Nijiiro Days
Райський поцілунок↑Paradise kiss|Paradise Kiss|ParaKiss
Раксефон: Сукупна Суголосність↑ラーゼフォン 多元変奏曲|RahXephon: Pluralitas Concentio|RahXephon: Harmonic Convergence
Раксефон: Сукупна Суголосність↑ラーゼフォン 多元変奏曲|RahXephon: Pluralitas Concentio|RahXephon: Harmonic Convergence
Раксефон: Сукупна Суголосність↑RahXephon: Tagen Hensoukyoku|RahXephon: Pluralitas Concentio|RahXephon: Harmonic Convergence|RahXephon: Pluralitas Concentio|RahXephon: Tagen Hensoukyoku
Ранма ½↑らんま1/2|Ranma ½|Ranma 1/2|Ranma ½ Nettou Hen
Рапсодія про довгі мандри по іншому світу↑Death March kara Hajimaru Isekai Kyousoukyoku|Death March to the Parallel World Rhapsody|Death March to the Parallel World Rhapsody|Death March kara Hajimaru Isekai Kyousoukyoku
Раґна Крімзон↑ラグナクリムゾン|Ragna Crimson
Ре-Мейн↑RE-MAIN（リメイン）|RE-MAIN
Революціонерка Утена↑少女革命ウテナ|Revolutionary Girl Utena|Shoujo Kakumei Utena
Рейтинг короля↑Ousama Ranking|Ranking of Kings|King Ranking|Ranking of Kings|Ousama Ranking
Рейтинг короля: Скарби хоробрості↑Ousama Ranking: Yuuki no Takarabako|Ranking of Kings: The Treasure Chest of Courage|Ranking of Kings: Treasure Chest of Courage|Ranking of Kings: The Treasure Chest of Courage|Ousama Ranking: Yuuki no Takarabako
Реквієм за королем троянд↑Baraou no Souretsu|Requiem of the Rose King|Requiem of the Rose King|Baraou no Souretsu
Реквієм по Фантому↑Phantom 〜Requiem for the Phantom〜|Phantom: Requiem for the Phantom
Рекомендації для чудового життя онлайн↑ネト充のススメ|Recovery of an MMO Junkie|Netojuu no Susume|Recommendation of the Wonderful Virtual Life
Репетитор-кілер Реборн!↑Katekyou Hitman Reborn!|Reborn!|Kateikyoushi Hitman Reborn!, Home Tutor Hitman Reborn!|Reborn!|Katekyou Hitman Reborn!
Ресторанчик з іншого світу↑Isekai Shokudou|Restaurant to Another World|Restaurant to Another World|Isekai Shokudou
Рецепт щастя↑Deaimon|Deaimon: Recipe for Happiness|Deaimon: Recipe for Happiness|Deaimon
Реінкарнація безробітного 2: В інший світ на повному серйозі (2 сезон, 1 частина)↑Mushoku Tensei II: Isekai Ittara Honki Dasu|Mushoku Tensei: Jobless Reincarnation Season 2|Jobless Reincarnation: I Will Seriously Try If I Go To Another World, Mushoku Tensei: Isekai Ittara Honki Dasu 2nd Season|Mushoku Tensei: Jobless Reincarnation Season 2|Mushoku Tensei II: Isekai Ittara Honki Dasu
Реінкарнація безробітного 2: В інший світ на повному серйозі (2 сезон, 2 частина)↑Mushoku Tensei II: Isekai Ittara Honki Dasu Part 2|Mushoku Tensei: Jobless Reincarnation Season 2 Part 2|Jobless Reincarnation: I Will Seriously Try If I Go To Another World, Mushoku Tensei: Isekai Ittara Honki Dasu 2nd Season Part 2|Mushoku Tensei: Jobless Reincarnation Season 2 Part 2|Mushoku Tensei II: Isekai Ittara Honki Dasu Part 2
Реінкарнація безробітного: В інший світ на повному серйозі↑Mushoku Tensei: Isekai Ittara Honki Dasu|Mushoku Tensei: Jobless Reincarnation|Jobless Reincarnation: I Will Seriously Try If I Go To Another World|Mushoku Tensei: Jobless Reincarnation|Mushoku Tensei: Isekai Ittara Honki Dasu
Реінкарнація безробітного: В інший світ на повному серйозі (Частина 2)↑無職転生 II ～異世界行ったら本気だす～|Mushoku Tensei: Jobless Reincarnation Season 2|Jobless Reincarnation: I Will Seriously Try If I Go To Another World|Mushoku Tensei: Isekai Ittara Honki Dasu 2nd Season
Рибка-бананка↑BANANA FISH|Banana Fish
Ринок Тамако↑たまこまーけっと|Tamako Market
Робот Ґеттер Арк / Ґеттер Робо Арк↑ゲッターロボ アーク|Getter Robo Arc|Getter Robo Āḥ|Getter Robo Ah|Getter Robo Ark
Робота Клітин: Код «Чорний»↑Hataraku Saibou Black|Cells at Work! CODE BLACK!|Cells at Work! CODE BLACK!|Hataraku Saibou Black
Робота для голосу↑こえでおしごと! The ANIMATION|Koe de Oshigoto!|Working with Voice!
Робота клітин↑Hataraku Saibou|Cells at Work!|Cells at Work!|Hataraku Saibou
Робота клітин!! (Сезон 2)↑Hataraku Saibou!!|Cells at Work!!|Cells at Work! 2nd Season, Hataraku Saibou 2nd Season|Cells at Work!!|Hataraku Saibou!!
Робота!!↑ワーキング!!|Wagnaria!!|Working!!
Робін Гуд↑Robin Hood no Daibouken|The Great Adventures of Robin Hood|The Great Adventures of Robin Hood|Robin Hood no Daibouken
Робін — мисливиця на відьом↑Witch Hunter ROBIN (ウイッチハンターロビン)|Witch Hunter Robin|WHR
Родом з Абіса↑メイドインアビス|Made in Abyss
Родом з Абіса. Золоте місто палаючого сонця↑Made in Abyss: Retsujitsu no Ougonkyou|Made in Abyss: The Golden City of the Scorching Sun|Made in Abyss: The Golden City of the Scorching Sun|Made in Abyss: Retsujitsu no Ougonkyou
Родом з Абіса: Світанок глибинної душі↑劇場版メイドインアビス 深き魂の黎明|Made in Abyss: Dawn of the Deep Soul|Gekijouban Made in Abyss: Fukaki Tamashii no Reimei|Made in Abyss: Dawn of the Deep Soul
Родом з Абіса: Світанок глибинної душі↑劇場版メイドインアビス 深き魂の黎明|Made in Abyss: Dawn of the Deep Soul|Gekijouban Made in Abyss: Fukaki Tamashii no Reimei
Родом з Абіса: Світанок глибинної душі↑劇場版メイドインアビス 深き魂の黎明|Made in Abyss: Dawn of the Deep Soul|Gekijouban Made in Abyss: Fukaki Tamashii no Reimei
Розарій + вампір (1 сезон)↑ロザリオとバンパイア|Rosario + Vampire|Rosario and Vampire
Розарій + вампір Цьом2↑ロザリオとバンパイア Capu2|Rosario + Vampire Capu2|Rosario + Vampire Season 2|Rosario and Vampire Capu2
Роззброєння↑ノー・ガンズ・ライフ|No Guns Life
Роззброєння 2↑ノー・ガンズ・ライフ|No Guns Life Season 2
Розкажи-но Галю!↑おしえて! ギャル子ちゃん|Please tell me! Galko-chan|Oshiete! Gyaruko-chan
Розквіт↑BLOSSOM|Blossom|Zapuni Project
Розкішний парк Амаґі↑甘城ブリリアントパーク|Amagi Brilliant Park|Amaburi
Рок Шоу!!↑SHOW BY ROCK!!（ショウ・バイ・ロック!!）|Show By Rock!!|SB69
Романтична комедія, де подруга дитинства нізащо не програє↑Osananajimi ga Zettai ni Makenai Love Comedy|Osamake: Romcom Where The Childhood Friend Won't Lose|The Romcom Where The Childhood Friend Won't Lose!, Osamake|Osamake: Romcom Where The Childhood Friend Won't Lose|Osananajimi ga Zettai ni Makenai Love Comedy
Ромео та Джульєта↑ロミオ×ジュリエット|Romeo x Juliet|RomeoxJuliet
Рубаки↑スレイヤーズ|Slayers|The Slayers|Slayers TV
Рубаки (сезон 2)↑スレイヤーズNEXT|Slayers Next
Рудоволоса Білосніжка↑赤髪の白雪姫|Snow White with the Red Hair|Akagami no Shirayukihime
Руйнівник Джо↑Crusher Joe|Crusher Joe: The Movie|Crusher Joe: The Movie|Crusher Joe
Руйнівник Небесних Сфер↑Doupo Cangqiong|Fights Break Sphere|Battle Through the Heavens|Fights Break Sphere|Doupo Cangqiong
Руйнівник Небесних Сфер (2 сезон)↑Doupo Cangqiong 2nd Season|Fights Break Sphere 2nd Season|Battle Through the Heavens 2nd Season|Fights Break Sphere 2nd Season|Doupo Cangqiong 2nd Season
Руки геть від Клубу Анімації!↑Eizouken ni wa Te wo Dasu na!|Keep Your Hands Off Eizouken!|Hands off the Motion Pictures Club!|Keep Your Hands Off Eizouken!|Eizouken ni wa Te wo Dasu na!
Русалонька – принцеса підводного королівства↑Andersen Douwa: Ningyohime|Hans Christian Anderson's The Little Mermaid|The Little Mermaid|Hans Christian Anderson's The Little Mermaid|Andersen Douwa: Ningyohime
Ріваіяс у нескінченності↑Mugen no Ryvius|Infinite Ryvius|Infinite Ryvius|Mugen no Ryvius
Ріж Рубай↑キルラキル|Kill la Kill|KLK|Dressed to Kill
Різнобарв'я↑カラフル|Colorful
Рілайф↑ReLIFE|Re LIFE
Рілайф - Фінальний розділ↑ReLIFE: Kanketsu-hen|ReLIFE: Final Arc|ReLIFE: Final Arc|ReLIFE: Kanketsu-hen
Рілаккума та Каору-сан↑リラックマとカオルさん|Rilakkuma and Kaoru
Рінкай!↑リンカイ!|Rinkai!
Сага про Вінланд↑Vinland Saga|Vinland Saga|Vinland Saga
Сага про Вінланд (сезон 2)↑ヴィンランド・サガ SEASON2|Vinland Saga Season 2
Сага про Гортензію↑オルタンシア・サーガ|Hortensia SAGA|Horsaga
Сад слів↑言の葉の庭|The Garden of Words|Koto no Ha no Niwa|The Garden of Kotonoha
Сад слів↑言の葉の庭|The Garden of Words|Koto no Ha no Niwa|The Garden of Kotonoha
Сад слів↑言の葉の庭|The Garden of Words|Koto no Ha no Niwa|The Garden of Kotonoha
Садистська суміш↑ブレンド・S|BLEND-S
Сайт чарівниць↑Mahou Shoujo Site|Magical Girl Site|Magical Girl Site|Mahou Shoujo Site
Саке Вакако↑ワカコ酒|Wakakozake|Wakako Sake
Самотнє небо↑ヨスガノソラ|Yosuga no Sora|Sky of Connection|Yosuga no Sora: In Solitude|Where We Are Least Alone
Самотній замок у дзеркалі↑かがみの孤城|Lonely Castle in the Mirror|The Solitary Castle in the Mirror
Самотній замок у дзеркалі↑かがみの孤城|Lonely Castle in the Mirror|The Solitary Castle in the Mirror
Самотній замок у дзеркалі↑Kagami no Kojou|Lonely Castle in the Mirror|The Solitary Castle in the Mirror|Lonely Castle in the Mirror|Kagami no Kojou
Самурай Чамплу↑サムライチャンプルー|Samurai Champloo|SAMURAI CHAMPLOO
Самітниця-рокер!↑ぼっち・ざ・ろっく！|Bocchi the Rock!
Санкареа↑Sankarea|Sankarea: Undying Love|Sankarea: Undying Love|Sankarea
Санкареа ОВА↑さんかれあ|Sankarea OVA|Sankarea Episodes 00 & 14
Санні бой↑Sonny Boy (サニーボーイ)|Sonny Boy
Сарадзаммай↑さらざんまい|Sarazanmai
Сарусубері. Дочка Хокусая↑百日紅～Miss HOKUSAI～|Miss Hokusai
Сасакі та Міяно↑佐々木と宮野|Sasaki and Miyano|Sasamiya
Сасакі та Міяно: Випуск↑Sasaki to Miyano Movie: Sotsugyou-hen|Sasaki and Miyano: Graduation|Sasamiya|Sasaki and Miyano: Graduation|Sasaki to Miyano Movie: Sotsugyou-hen
Сасакі та Пі↑Sasaki to Pii-chan|Sasaki and Peeps|Sasaki to P-chan|Sasaki and Peeps|Sasaki to Pii-chan
Сатана на заробітках (2 сезон, 1 частина)↑Hataraku Maou-sama!!|The Devil is a Part-Timer! Season 2|The Devil is a Part-Timer! 2nd Season, The Devil is a Part-Timer!!, Hataraku Maou-sama 2|The Devil is a Part-Timer! Season 2|Hataraku Maou-sama!!
Сатана на заробітках!↑はたらく魔王さま!|The Devil is a Part-Timer!|Hataraku Maou-sama!
Сатана на підробітку!! (2 сезон, 2 частина)↑Hataraku Maou-sama!! 2nd Season|The Devil is a Part-Timer! Season 2 (Sequel)|The Devil is a Part-Timer! 3rd Season, Hataraku Maou-sama 3|The Devil is a Part-Timer! Season 2 (Sequel)|Hataraku Maou-sama!! 2nd Season
Сворд Арт Онлайн / Мистецтво Меча Онлайн (1 сезон)↑ソードアート・オンライン|Sword Art Online|S.A.O|SAO
Сворд Арт Онлайн / Мистецтво Меча Онлайн (2 сезон)↑Sword Art Online II|Sword Art Online II|Phantom Bullet, SAO II, Sword Art Online 2, SAO 2|Sword Art Online II
Сворд Арт Онлайн: Алісізація (сезон 3)↑ソードアート・オンライン アリシゼーション|Sword Art Online: Alicization|Sword Art Online III|SAO Alicization|Sword Art Online 3|SAO 3
Сворд Арт Онлайн: Алісізація - Війна за Підсвіт. Частина 1 (2 сезон)↑ソードアート・オンライン アリシゼーション War of Underworld|Sword Art Online: Alicization - War of Underworld|Sword Art Online: Alicization 2nd Season|Sword Art Online III 2nd Season|SAO Alicization 2nd Season|Sword Art Online 3 2nd Season|SAO 3 2nd Season|SAO III 2nd Season
Сворд Арт Онлайн: Алісізація - Війна за Підсвіт. Частина 2↑ソードアート・オンライン アリシゼーション War of Underworld|Sword Art Online: Alicization - War of Underworld|Sword Art Online: Alicization 2nd Season|Sword Art Online III 2nd Season|SAO Alicization 2nd Season|Sword Art Online 3 2nd Season|SAO 3 2nd Season|SAO III 2nd Season
Сворд Арт Онлайн: Ординал Скейл↑Sword Art Online Movie: Ordinal Scale|Sword Art Online the Movie: Ordinal Scale|Gekijouban Sword Art Online|Sword Art Online the Movie: Ordinal Scale|Sword Art Online Movie: Ordinal Scale
Сворд Арт Онлайн: Ординал Скейл↑Sword Art Online Movie: Ordinal Scale|Sword Art Online the Movie: Ordinal Scale|Gekijouban Sword Art Online|Sword Art Online the Movie: Ordinal Scale|Sword Art Online Movie: Ordinal Scale
Свята Сесилія та Пастор Лоуренс↑Shiro Seijo to Kuro Bokushi|Saint Cecilia and Pastor Lawrence|White Saint and Black Pastor|Saint Cecilia and Pastor Lawrence|Shiro Seijo to Kuro Bokushi
Свято ляльок / Хінамацурі↑ひなまつり|Hinamatsuri
Святі юнаки↑聖☆おにいさん|Saint☆Young Men|Saint☆Onii-san|Saint Onii-san
Святі юнаки ОВА↑聖☆おにいさん|Saint☆Young Men|Saint☆Onii-san|Saint Onii-san
Священна війна Церберус: крах епохи дракона↑聖戦ケルベロス　竜刻のファタリテ|Cerberus|Seisen Cerberus: Ryuukoku no Fatalite
Священна любов↑コイ☆セント|Coicent|Koi☆Cent|Koisento
Світ Удону Поко↑Udon no Kuni no Kiniro Kemari|Poco's Udon World|Gaogao-chan to Aoi Sora|Poco's Udon World|Udon no Kuni no Kiniro Kemari
Світ врятують авантюристи, які не вірять в людство↑Ningen Fushin no Boukensha-tachi ga Sekai wo Sukuu you desu|Ningen Fushin: Adventurers Who Don't Believe in Humanity Will Save the World|Apparently, Disillusioned Adventurers Will Save the World|Ningen Fushin: Adventurers Who Don't Believe in Humanity Will Save the World|Ningen Fushin no Boukensha-tachi ga Sekai wo Sukuu you desu
Світ відомий лиш Богу (2 сезон)↑Kami nomi zo Shiru Sekai II|The World God Only Knows II|Kami nomi zo Shiru Sekai 2, Kaminomi II, The World God Only Knows 2|The World God Only Knows II|Kami nomi zo Shiru Sekai II
Світ відомий лиш богу - 100% Магічна ☆Зірка Канон↑マジカル☆スター　かのん100％|Magical Star Kanon 100%!|Kami nomi zo Shiru Sekai: Kanon OVA|Magical Star Kanon 100%
Світ відомий лиш богу - 100% Магічна ☆Зірка Канон↑マジカル☆スター　かのん100％|Magical Star Kanon 100%!|Kami nomi zo Shiru Sekai: Kanon OVA|Magical Star Kanon 100%
Світ відомий лиш богу ОВА - Чотири дівчини плюс один Ідол↑神のみぞ知るセカイ　４人とアイドル|The World God Only Knows: Four Girls and an Idol|Kami nomi zo Shiru Sekai: Yonin to Idol|Kaminomi OVA|Kami Nomi zo Shiru Sekai OVA|The World God Only Knows: Four People and an Idol
Світ відомий лиш богу ОВА - Чотири дівчини плюс один Ідол↑神のみぞ知るセカイ　４人とアイドル|The World God Only Knows: Four Girls and an Idol|Kami nomi zo Shiru Sekai: Yonin to Idol|Kaminomi OVA|Kami Nomi zo Shiru Sekai OVA|The World God Only Knows: Four People and an Idol
Світ відомий лиш богу ОВА - Чотири дівчини плюс один Ідол↑神のみぞ知るセカイ　４人とアイドル|The World God Only Knows: Four Girls and an Idol|Kami nomi zo Shiru Sekai: Yonin to Idol|Kaminomi OVA|Kami Nomi zo Shiru Sekai OVA|The World God Only Knows: Four People and an Idol
Світанкова Йона↑Akatsuki no Yona|Yona of the Dawn|Yona: The girl standing in the blush of dawn|Yona of the Dawn|Akatsuki no Yona
Світанкова Пісня Лу↑Yoake Tsugeru Lu no Uta|Lu Over the Wall|Song of Lu who Informs the Dawn|Lu Over the Wall|Yoake Tsugeru Lu no Uta
Світанок Відьми↑魔法使い黎明期|The Dawn of the Witch|Mahou Tsukai Reimeiki
Сейлор Воїтельки, Перетворіться!↑Bishoujo Senshi Sailor Moon R: Make Up! Sailor Senshi|Sailor Moon R: Make Up! Sailor Guardians|Sailor Moon R: Make Up! Sailor Guardians|Bishoujo Senshi Sailor Moon R: Make Up! Sailor Senshi
Сейлор Мун (1 сезон)↑Bishoujo Senshi Sailor Moon|Sailor Moon|Pretty Soldier Sailor Moon|Sailor Moon|Bishoujo Senshi Sailor Moon
Сейлор Мун (5 сезон)↑美少女戦士セーラームーン セーラースターズ|Sailor Moon Sailor Stars|Pretty Soldier Sailor Moon: Sailor Stars
Сейлор Мун R (2 сезон)↑Bishoujo Senshi Sailor Moon R|Sailor Moon R|Pretty Soldier Sailor Moon R|Sailor Moon R|Bishoujo Senshi Sailor Moon R
Сейлор Мун R: Обіцянка троянди↑美少女戦士セーラームーンＲ THE MOVIE|Sailor Moon R: The Movie - The Promise of the Rose|Sailor Moon R Movie: Dangerous Flowers
Сейлор Мун R: Обіцянка троянди↑美少女戦士セーラームーンＲ THE MOVIE|Sailor Moon R: The Movie - The Promise of the Rose|Sailor Moon R Movie: Dangerous Flowers|Bishoujo Senshi Sailor Moon R: The Movie
Сейлор Мун R: Обіцянка троянди↑美少女戦士セーラームーンＲ THE MOVIE|Sailor Moon R: The Movie - The Promise of the Rose|Sailor Moon R Movie: Dangerous Flowers
Сейлор Мун S: Коханий принцеси Каґуї↑美少女戦士セーラームーンS かぐや姫の恋人|Sailor Moon S Movie: Hearts in Ice|Bishoujo Senshi Sailor Moon S: The Movie|Bishoujo Senshi Sailor Moon S: Kaguya Hime no Koibito|Sailor Moon S: Snowprincess Kaguya
Семеро святих↑トリニティセブン|Trinity Seven
Семиденна війна↑Bokura no Nanokakan Sensou|Seven Days War|7 Days War, Our Seven-Day War|Seven Days War|Bokura no Nanokakan Sensou
Сен та Чіхіро в полоні у духів|Віднесені привидами↑千と千尋の神隠し|Spirited Away|Sen and Chihiro's Spiriting Away
Сен та Чіхіро в полоні у духів|Віднесені привидами|Віднесені привидами / Сен та Чіхіро в полоні у духів↑千と千尋の神隠し|Spirited Away|Sen and Chihiro's Spiriting Away
Сен та Чіхіро у полоні духів / Віднесені привидами↑Sen to Chihiro no Kamikakushi|Spirited Away|Sen and Chihiro's Spiriting Away|Spirited Away|Sen to Chihiro no Kamikakushi
Сенкорол↑センコロール|Cencoroll|Cencoroll
Сенкорол↑センコロール|Cencoroll
Сенкорол↑センコロール|Cencoroll
Сенкорол. Підключення↑センコロール|Cencoroll Connect|Cencoroll 2
Сенкорол. Підключення↑センコロール|Cencoroll Connect|Cencoroll 2
Сенкорол. Підключення↑センコロール|Cencoroll Connect|Cencoroll 2
Сервамп↑SERVAMP（サーヴァンプ）|SERVAMP
Серця Пандори↑パンドラハーツ|Pandora Hearts
Сестри-відьми Йойо та Нене↑魔女っこ姉妹のヨヨとネネ|Magical Sisters Yoyo & Nene|Majocco Shimai no Yoyo to Nene
Сила святої всеосяжна↑Seijo no Maryoku wa Bannou desu|The Saint's Magic Power is Omnipotent|The power of the saint is all around|The Saint's Magic Power is Omnipotent|Seijo no Maryoku wa Bannou desu
Сила святої всеосяжна (Сезон 2)↑聖女の魔力は万能です Season2|The Saint's Magic Power is Omnipotent Season 2|Seijo no Maryoku wa Bannou desu 2nd Season|The power of the saint is all around Season 2
Синдуальність: Нуар↑SYNDUALITY Noir|Synduality: Noir
Синя в'язниця↑ブルーロック|Blue Lock
Синій оркестр↑Ao no Orchestra|Blue Orchestra|The Blue Orchestra|Blue Orchestra|Ao no Orchestra
Скажений бик з 34-го↑マッド★ブル34|Mad Bull 34
Скажи: «я тебе кохаю»↑好きっていいなよ。|Say "I Love You."|Suki-tte Ii na yo.|Sukinayo
Сказання про Арслана (1 сезон)↑Arslan Senki (TV)|The Heroic Legend of Arslan|The Heroic Legend of Arslan|Arslan Senki (TV)
Сказання про богів та демонів↑妖神记|Yao Shen Ji|Demon Gods|Tales of Demons and Gods
Сказання про демонів сакури↑薄桜鬼|Hakuoki ~Demon of the Fleeting Blossom~|Hakuoki|Hakuouki: Shinsengumi Kitan
Сказання про демонів сакури: Арка блакитної крові↑Hakuouki: Hekketsuroku|Hakuoki: Demon of the Fleeting Blossom - Record of the Jade Blood|Hakuouki 2, Hakuoki 2, Hakuouki Shinsengumi Kitan Hekketsuroku|Hakuoki: Demon of the Fleeting Blossom - Record of the Jade Blood|Hakuouki: Hekketsuroku
Скарлет Нексус↑SCARLET NEXUS|Scarlet Nexus
Скейт: Безкінечність↑SK∞|SK8 the Infinity|SK Eight, Skate|SK8 the Infinity|SK∞
Складне життя другорядного персонажа в отоме-грі↑乙女ゲー世界はモブに厳しい世界です|Trapped in a Dating Sim: The World of Otome Games is Tough for Mobs|Otomege Sekai wa Mob ni Kibishii Sekai desu|Mobseka|Mobuseka
Скляний Океан↑クジラの跳躍|Kujira no Chouyaku|Glassy Ocean
Скляний Океан↑クジラの跳躍|Kujira no Chouyaku|Glassy Ocean
Скляний Океан↑クジラの跳躍|Kujira no Chouyaku|Glassy Ocean
Скромні герої. Краб, яйце та невидимка↑Chiisana Eiyuu: Kani to Tamago to Toumei Ningen|Modest Heroes|Ponoc Tanpen Gekijou, Ponoc Short Films Theatre|Modest Heroes|Chiisana Eiyuu: Kani to Tamago to Toumei Ningen
Скільки кіло потягнеш ти?↑Dumbbell Nan Kilo Moteru?|How Heavy Are the Dumbbells You Lift?|How Many Kilograms are the Dumbbells You Lift?|How Heavy Are the Dumbbells You Lift?|Dumbbell Nan Kilo Moteru?
Славнозвісний / Прославлений↑うたわれるもの|Utawarerumono|The One Being Sung
Слем-Данк↑スラムダンク|Slam Dunk
Слова бурують, як бульбашки в пляшці↑Cider no You ni Kotoba ga Wakiagaru|Words Bubble Up Like Soda Pop|Words Bubble Up Like Soda Pop|Cider no You ni Kotoba ga Wakiagaru
Слухай мене, хвиле!↑波よ聞いてくれ|Wave, Listen to Me!|Nami yo Kiite Kure
Слухачі↑LISTENERS リスナーズ|Listeners
Сльози Тіари↑ティアーズ・トゥ・ティアラ|Tears to Tiara
Смаколик↑おまえうまそうだな|Heart and Yummie|Omae Umasou da na|You Are Umasou
Смаколики з підземелля↑Dungeon Meshi|Delicious in Dungeon|Dungeon Food|Delicious in Dungeon|Dungeon Meshi
Смертельний більярд↑デス・ビリヤード|Death Billiards|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012
Смертельний більярд↑デス・ビリヤード|Death Billiards|Wakate Animator Ikusei Project|2012 Young Animator Training Project|Anime Mirai 2012
Смута: криваво-сніжна принцеса↑擾乱 THE PRINCESS OF SNOW AND BLOOD|Joran The Princess of Snow and Blood
Сни зброї / Бойовий ангел Аліта↑銃夢 GUNNM|Battle Angel Alita|Ganmu|Tsutsu Yume: Gunnm|Battle Angel|Hyper Future Vision: Gunnm
Собачі Дні↑ドッグデイズ|Dog Days
Сол Б'янка↑SOL BIANCA (ソル·ビアンカ)|Sol Bianca
Солодке переродження↑Okashi na Tensei|Sweet Reincarnation|Treat of Reincarnation|Sweet Reincarnation|Okashi na Tensei
Солодкі сліди укусів↑甜美的咬痕|Sweet Bite Marks|Tianmei De Yaohen
Солодощі та блискавка↑Amaama to Inazuma|Sweetness & Lightning|Sweetness & Lightning|Amaama to Inazuma
Сомалі та Лісовий Дух↑Somali to Mori no Kamisama|Somali and the Forest Spirit|Somali and the Forest Spirit|Somali to Mori no Kamisama
Сон Літнього Дня↑東方二次創作同人アニメ 夢想夏郷|Touhou Niji Sousaku Doujin Anime: Musou Kakyou|Touhou Unofficial Doujin Anime: A Summer Day's Dream
Сон в Замку Демона↑Maoujou de Oyasumi|Sleepy Princess in the Demon Castle|Sleeping in Devil's Castle|Sleepy Princess in the Demon Castle|Maoujou de Oyasumi
Сонячний день↑陽あたり良好！|Sunny Ryoko|Hiatari Ryoukou
Сонік Ікс↑ソニック X|Sonic X
Соромливка↑シャイ|Shy
Спадкоємець диявола 2↑デビルサバイバー２ THE ANIMATION|Devil Survivor 2 The Animation|DS2A|Shin Megami Tensei: Devil Survivor 2
Спалах мрійників↑厨病激発ボーイ|Outburst Dreamer Boys|Juubyou Gekikatsu Boy|Young Disease Outburst Boy
Спалити відьму↑BURN THE WITCH|Burn the Witch
Спецклас А↑スペシャル・エー|Special A (S.A)|S.A.|Special A Class
Спеціальний відділ з розслідування злочинів: Сімка↑Keishichou Tokumubu Tokushu Kyouakuhan Taisakushitsu Dainanaka: Tokunana|Special 7: Special Crime Investigation Unit|Special 7: Special Crime Investigation Unit|Keishichou Tokumubu Tokushu Kyouakuhan Taisakushitsu Dainanaka: Tokunana
Спляча красуня: історія про невідому мене↑ひるね姫～知らないワタシの物語～|Napping Princess|Napping Princess: The Story of the Unknown Me|Ancien and the Magic Tablet
Спляча красуня: історія про невідому мене↑ひるね姫～知らないワタシの物語～|Napping Princess|Napping Princess: The Story of the Unknown Me|Ancien and the Magic Tablet
Спляча красуня: історія про невідому мене↑Hirune Hime: Shiranai Watashi no Monogatari|Napping Princess|Napping Princess: The Story of the Unknown Me, Ancien and the Magic Tablet|Napping Princess|Hirune Hime: Shiranai Watashi no Monogatari
Сплітаючи човен зі слів↑Fune wo Amu|The Great Passage|The Great Passage|Fune wo Amu
Спогади↑Memories|Memories (Music)
Спогади про Марні|Спогади Мані↑思い出のマーニー|When Marnie Was There
Спогади про Марні|Спогади Мані|Спогади про Марні / Спогади Мані↑思い出のマーニー|When Marnie Was There|When Marnie Was There / Omoide no Marnie
Спогади про Марні|Спогади Мані↑Omoide no Marnie|When Marnie Was There|When Marnie Was There|Omoide no Marnie
Спогади про одного пілота↑とある飛空士への追憶|The Princess and the Pilot|To Aru Hikuushi e no Tsuioku|Recollection of a Certain Airship Pilot
Спостерігаючи колготи|Споглядаючи колготки↑みるタイツ|Miru Tights
Справа Хани та Аліси↑花とアリス 殺人事件|The Case of Hana & Alice|Hana & Alice: The Murder Case
Справа ювеліра Річарда↑Housekishou Richard-shi no Nazo Kantei|The Case Files of Jeweler Richard|The Case Files of Jeweler Richard|Housekishou Richard-shi no Nazo Kantei
Спріґґан|Спріґан↑スプリガン|Spriggan
Спріґґан|Спріґан↑スプリガン|Spriggan
Спріґґан|Спріґан↑スプリガン|Spriggan
Спів китенят серед пісків↑Kujira no Kora wa Sajou ni Utau|Children of the Whales|Whale Calves Sing on the Sand, Tales of the Wales Calves|Children of the Whales|Kujira no Kora wa Sajou ni Utau
Співачки↑Ongaku Shoujo|Music Girl|Wakate Animator Ikusei Project, 2015 Young Animator Training Project, Anime Mirai 2015|Music Girl|Ongaku Shoujo
Співуча пташка крильцями не тріпоче. Збираються хмари↑Saezuru Tori wa Habatakanai: The Clouds Gather|Twittering Birds Never Fly|Twittering Birds Never Fly|Saezuru Tori wa Habatakanai: The Clouds Gather
Спід Ґрафер↑スピードグラファー|Speed Grapher
Спілкування з демі↑亜人ちゃんは語りたい|Interviews With Monster Girls|Ajin-chan wa Kataritai
Спільнота «Ґатчамен»↑ガッチャマン クラウズ|Gatchaman Crowds
Спільнота «Ґатчамен»: Інтуїція↑GATCHAMAN CROWDS insight（インサイト）|Gatchaman Crowds Insight|Gatchaman Crowds 2nd Season|Gatchaman Crowds Second Season
Срібна ложка (1 сезон)↑Gin no Saji|Silver Spoon|Silver Spoon|Gin no Saji
Срібна ложка (2 сезон)↑Gin no Saji 2nd Season|Silver Spoon 2nd Season|Silver Spoon 2nd Season|Gin no Saji 2nd Season
Срібноволосий Аґіто↑銀色の髪のアギト|Origin: Spirits of the Past|Gin-iro no Kami no Agito|Silver-Haired Agito
Срібноволосий Аґіто / Витік: Духи минулого↑銀色の髪のアギト|Origin: Spirits of the Past|Gin-iro no Kami no Agito|Silver-Haired Agito
Ставши псом моєї коханої↑Inu ni Nattara Suki na Hito ni Hirowareta.|My Life as Inukai-san's Dog.|Inuhiro|My Life as Inukai-san's Dog.|Inu ni Nattara Suki na Hito ni Hirowareta.|My Life as Inukai-san's Dog
Сталева тривога! (1 сезон)↑Full Metal Panic!|Full Metal Panic!|FMP, Fullmetal Panic!|Full Metal Panic!
Сталева тривога! IV Невидима Перемога↑フルメタル・パニック！Invisible Victory|Full Metal Panic! Invisible Victory|Full Metal Panic! IV
Сталева тривога! Нове завдання↑フルメタル パニック！The Second Raid|Full Metal Panic! The Second Raid|Full Metal Panic! TSR
Сталева тривога? Фумоффу (2 сезон)↑フルメタル・パニック? ふもっふ|Full Metal Panic? Fumoffu|Full Metal Panic Fumoffu|Fullmetal Panic? Fumoffu
Сталевий Алхімік: Завойовник Шамбали↑劇場版 鋼の錬金術師 シャンバラを征く者|Fullmetal Alchemist: The Movie - Conqueror of Shamballa|Gekijyouban Hagane no Renkinjutsushi - Shanbara wo Yuku Mono|Fullmetal Alchemist the Movie: Conqueror of Shamballa|FMA Movie
Сталевий Алхімік: Завойовник Шамбали↑劇場版 鋼の錬金術師 シャンバラを征く者|Fullmetal Alchemist: The Movie - Conqueror of Shamballa|Gekijyouban Hagane no Renkinjutsushi - Shanbara wo Yuku Mono|Fullmetal Alchemist the Movie: Conqueror of Shamballa|FMA Movie
Сталевий алхімік↑鋼の錬金術師|Fullmetal Alchemist|Hagane no Renkinjutsushi|FMA|Full Metal Alchemist
Сталевий алхімік братерство, комічний театр↑荒川弘 描き下ろし4コマ劇場|Fullmetal Alchemist: Brotherhood 4-koma Theater|Hagane no Renkinjutsushi: Hagaren 4-koma Gekijou|Hiromu Arakawa 4-koma Theater|FMA: 4-koma Theater
Сталевий алхімік: Братерство|Сталевий алхімік. Братерство↑鋼の錬金術師 FULLMETAL ALCHEMIST|Fullmetal Alchemist: Brotherhood|Hagane no Renkinjutsushi: Fullmetal Alchemist|Fullmetal Alchemist (2009)|FMA|FMAB
Сталевий алхімік: священна зірка Мілоса↑劇場版 鋼の錬金術師 嘆きの丘(ミロス)の聖なる星|Fullmetal Alchemist: The Sacred Star of Milos|Fullmetal Alchemist: Milos no Seinaru Hoshi|Fullmetal Alchemist Movie 2|Hagane no Renkinjutsushi Movie 2|FMA Movie 2
Становлення Героя-звіролюба↑Hataage! Kemono Michi|Kemono Michi: Rise Up|Kemono Michi: Rise Up|Hataage! Kemono Michi
Становлення Легенди↑Diamond no Ace|Ace of Diamond|Daiya no Ace, Ace of the Diamond, Dia no A|Ace of Diamond|Diamond no Ace
Старша карта↑HIGH CARD|High Card
Старша карта 2↑HIGH CARD season 2|High Card Season 2
Старша школа DxD (Нове)↑ハイスクールD×D NEW|High School DxD New|High School DxD Dai 2-ki|High School DxD 2nd Season|High School DxD Second Season|Highschool DxD 2
Старша школа DxD. Народження↑ハイスクールD×D BorN|High School DxD BorN|High School DxD Third Season|High School DxD 3rd Season|Highschool DxD BorN
Старша школа DхD↑ハイスクールD×D|High School DxD|Highschool DxD
Старша школа Усакаме↑うさかめ|Usakame
Старша школа мертвих↑学園黙示録 HIGHSCHOOL OF THE DEAD|High School of the Dead|Gakuen Mokushiroku: Highschool of the Dead|HOTD|HSOTD
Старшокласниці↑女子高生 GIRL'S HIGH|High School Girls|Joshi Kousei: Girl's High
Стімбой↑スチームボーイ|Steamboy
Стімбой↑スチームボーイ|Steamboy
Стімбой↑スチームボーイ|Steamboy
Судзуме, що зачиняє двері|Судзуме, що закриває двері|Судзуме зачиняє двері↑すずめの戸締まり|Suzume|Suzume's Door-Locking
Судзуме, що зачиняє двері|Судзуме, що закриває двері|Судзуме зачиняє двері↑すずめの戸締まり|Suzume|Suzume's Door-Locking
Судзуме, що зачиняє двері|Судзуме, що закриває двері|Судзуме зачиняє двері↑Suzume no Tojimari|Suzume|Suzume's Door-Locking|Suzume|Suzume no Tojimari
Супер Каб↑スーパーカブ|Super Cub
Супервимірна фортеця Макросс↑超時空要塞マクロス|Macross|Choujikuu Yousai Macross|Cho Jiku Yosai Macross|Super Dimension Fortress Macross|SDF Macross|Robotech (U.S.)
Суперкнига (сезон 1)↑Anime Oyako Gekijou|Superbook|Superbook|Anime Oyako Gekijou
Суперкнига (сезон 2)↑Personal Computer Travel Tanteidan|Superbook 2|Superbook: Bible Stories|Superbook 2|Personal Computer Travel Tanteidan
Сутінкова дівчина і Амнезія↑黄昏乙女×アムネジア|Dusk Maiden of Amnesia|Tasogare Otome x Amnesia
Сутінковий розум 2041↑NIGHT HEAD 2041|Night Head 2041
Сходження в тіні↑Kage no Jitsuryokusha ni Naritakute!|The Eminence in Shadow|Shadow Garden|The Eminence in Shadow|Kage no Jitsuryokusha ni Naritakute!
Сходження в тіні (2 сезон)↑Kage no Jitsuryokusha ni Naritakute! 2nd Season|The Eminence in Shadow Season 2|Shadow Garden 2nd Season|The Eminence in Shadow Season 2|Kage no Jitsuryokusha ni Naritakute! 2nd Season
Сходження героя щита↑Tate no Yuusha no Nariagari|The Rising of the Shield Hero|The Rising of the Shield Hero|Tate no Yuusha no Nariagari
Сходження героя щита (2 сезон)↑Tate no Yuusha no Nariagari Season 2|The Rising of the Shield Hero Season 2|Tate no Yuusha no Nariagari 2nd Season|The Rising of the Shield Hero Season 2|Tate no Yuusha no Nariagari Season 2
Сходження героя щита (3 сезон)↑Tate no Yuusha no Nariagari Season 3|The Rising of the Shield Hero Season 3|Tate no Yuusha no Nariagari 3rd Season, The Rising of the Shield Hero 3rd Season|The Rising of the Shield Hero Season 3|Tate no Yuusha no Nariagari Season 3
Сходження мерця Смертельна гра↑デッドマウント・デスプレイ|Dead Mount Death Play
Сходження мерця Смертельна гра (сезон 1, частина 2)↑デッドマウント・デスプレイ|Dead Mount Death Play Part 2
Східний Едем↑東のエデン|Eden of The East|Higashi no Eden
Східний Едем: Втрачений Рай↑東のエデン 劇場版II Paradise Lost|Eden of The East the Movie II: Paradise Lost|Higashi no Eden: Gekijouban II Paradise Lost
Східний Едем: Втрачений Рай↑東のエデン 劇場版II Paradise Lost|Eden of The East the Movie II: Paradise Lost|Higashi no Eden: Gekijouban II Paradise Lost|Eden of the East Movie II: Paradise Lost
Східний Едем: Втрачений Рай↑東のエデン 劇場版II Paradise Lost|Eden of The East the Movie II: Paradise Lost|Higashi no Eden: Gekijouban II Paradise Lost
Східний Едем: Фільм перший — Король Едему↑東のエデン 劇場版I The King of Eden|Eden of The East the Movie I: The King of Eden|Higashi no Eden: Gekijouban I The King of Eden
Східний Едем: Фільм перший — Король Едему↑東のエデン 劇場版I The King of Eden|Eden of The East the Movie I: The King of Eden|Higashi no Eden: Gekijouban I The King of Eden|Eden of the East Movie I: The King of Eden
Сьогодні Аска показує↑今日のあすかショー|Today's Asuka Show
Сьогодні почалось наше кохання↑Kyou, Koi wo Hajimemasu|Today We Start Our Love|Today We Start Our Love|Kyou, Koi wo Hajimemasu
Сьогоднішнє меню для родини Емія↑Emiya-san Chi no Kyou no Gohan|Today's Menu for the Emiya Family|Today's Menu for the Emiya Family|Emiya-san Chi no Kyou no Gohan
Сьома петля часу: Лиходійка насолоджується безтурботним життям у шлюбі зі своїм найлютішим ворогом!↑Loop 7-kaime no Akuyaku Reijou wa, Moto Tekikoku de Jiyuu Kimama na Hanayome Seikatsu wo Mankitsu suru|7th Time Loop: The Villainess Enjoys a Carefree Life Married to Her Worst Enemy!|The Villainess Wants to Enjoy a Carefree Married Life in a Former Enemy Country in Her Seventh Loop!, The Villainess of 7th Time Loop Enjoys Free-Spirited Bride Life in the Former Hostile Country|7th Time Loop: The Villainess Enjoys a Carefree Life Married to Her Worst Enemy!|Loop 7-kaime no Akuyaku Reijou wa, Moto Tekikoku de Jiyuu Kimama na Hanayome Seikatsu wo Mankitsu suru
Сяючий стовп↑シャインポスト|Shine Post
Сільський лікар↑Inaka Isha|Franz Kafka's A Country Doctor|Kafka Inaka Isha, Ein Landarzt|Franz Kafka's A Country Doctor|Inaka Isha
Сім Смертних Гріхів↑Nanatsu no Taizai|The Seven Deadly Sins|The Seven Deadly Sins|Nanatsu no Taizai
Сім Смертних Гріхів - Сліди Священної Війни↑Nanatsu no Taizai: Seisen no Shirushi|The Seven Deadly Sins: Signs of Holy War|The Seven Deadly Sins: Signs of Holy War|Nanatsu no Taizai: Seisen no Shirushi
Сім Смертних Гріхів 2↑Nanatsu no Taizai: Imashime no Fukkatsu|The Seven Deadly Sins: Revival of the Commandments|Seven Deadly Sins Season 2|The Seven Deadly Sins: Revival of the Commandments|Nanatsu no Taizai: Imashime no Fukkatsu
Сім Смертних Гріхів. В'язні небес↑Nanatsu no Taizai Movie 1: Tenkuu no Torawarebito|The Seven Deadly Sins the Movie: Prisoners of the Sky|The Seven Deadly Sins: Prisoners of the Sky|The Seven Deadly Sins the Movie: Prisoners of the Sky|Nanatsu no Taizai Movie 1: Tenkuu no Torawarebito
Сім Смертних Гріхів. В’язні небес↑劇場版 七つの大罪 天空の囚われ人|The Seven Deadly Sins the Movie: Prisoners of the Sky|The Seven Deadly Sins: Prisoners of the Sky
Сім Смертних Гріхів. Гнів Богів↑Nanatsu no Taizai: Kamigami no Gekirin|The Seven Deadly Sins: Imperial Wrath of the Gods|The Seven Deadly Sins: Imperial Wrath of the Gods|Nanatsu no Taizai: Kamigami no Gekirin
Сім Смертних Гріхів. Суд Гніву↑七つの大罪 憤怒の審判|The Seven Deadly Sins: Dragon's Judgement|Nanatsu no Taizai: Fundo no Shinpan
Сім смертних гріхів. Чотири лицарі Апокаліпсису↑Nanatsu no Taizai: Mokushiroku no Yonkishi|The Seven Deadly Sins: Four Knights of the Apocalypse|The Seven Deadly Sins: Four Knights of the Apocalypse|Nanatsu no Taizai: Mokushiroku no Yonkishi
Сім смертних гріхів: Прокляття світла↑劇場版 七つの大罪 光に呪われし者たち|The Seven Deadly Sins the Movie 2: Cursed By Light|Gekijouban Nanatsu no Taizai Hikari ni Norowareshi Mono-tachi|The Seven Deadly Sins the Movie: Cursed by Light
Сім смертних гріхів: Прокляття світла↑劇場版 七つの大罪 光に呪われし者たち|The Seven Deadly Sins the Movie 2: Cursed By Light|Gekijouban Nanatsu no Taizai Hikari ni Norowareshi Mono-tachi|The Seven Deadly Sins the Movie: Cursed by Light|The Seven Deadly Sins: Cursed by Light
Сім'я шпигуна (2 сезон)↑SPY×FAMILY Season 2|Spy x Family Season 2
Сім'я шпигуна / Шпигун та сім'я (сезон 1, частина 1)↑Spy x Family|Spy x Family|Spy x Family
Сім'я шпигуна / Шпигун та сім'я (сезон 1, частина 2)↑Spy x Family Part 2|Spy x Family Part 2|Spy x Family Part 2
Сімейка Мінамі↑みなみけ|Minami-ke|Minamike|The Minami Family
Сімейне життя легковажної відьми↑Dekoboko Majo no Oyako Jijou|The Family Circumstances of the Irregular Witch|The Family Circumstances of the Mismatched Witches|The Family Circumstances of the Irregular Witch|Dekoboko Majo no Oyako Jijou
Сімейні труднощі родини Яґамі↑八神くんの家庭の事情|Yagami-kun no Katei no Jijou|Yagami's Family Affairs|Yagami-kun's Family Affairs
Сісти на поїзд X↑X電車で行こう|X Densha de Ikou|Take the X Train
Тавро вітру↑風のスティグマ|Kaze no Stigma|Kaze no Seikon|Stigma of the Wind
Тада-кун не закохується↑Tada-kun wa Koi wo Shinai|Tada Never Falls in Love|Tada Doesn't Fall in Love, TadaKoi|Tada Never Falls in Love|Tada-kun wa Koi wo Shinai
Тайфун Норуда↑台風のノルダ|Typhoon Noruda
Так складно покохати отаку|Тяжке кохання в отаку↑Wotaku ni Koi wa Muzukashii|Wotakoi: Love is Hard for Otaku|It's Difficult to Love an Otaku|Wotakoi: Love is Hard for Otaku|Wotaku ni Koi wa Muzukashii
Так, ні, можливо...↑Yes ka No ka Hanbun ka|Yes, No, or Maybe?|Yes, No, or Maybe Half?|Yes, No, or Maybe?|Yes ka No ka Hanbun ka
Такт Опус. Доля↑takt op.Destiny|Takt Op. Destiny
Такі стосунки не можна назвати коханням↑Koi to Yobu ni wa Kimochi Warui|Koikimo|It's Too Sick to Call this Love|Koikimo|Koi to Yobu ni wa Kimochi Warui
Танець клинка↑精霊使いの剣舞〈ブレイドダンス〉ミニOVA|Blade Dance of the Elementalers Specials|Seirei Tsukai no Blade Dance Mini OVA
Танець на Узбережжі Вампірів↑ダンスインザヴァンパイアバンド|Dance in the Vampire Bund
Танцюй, танцюй, танцюристе↑ダンス・ダンス・ダンスール|Dance Dance Danseur
Танці з дияволами↑ダンス・ウィズ・デビルス|Dance with Devils
Татусі мимоволі↑Buddy Daddies
Таємне життя пінгвінів↑ペンギン・ハイウェイ|Penguin Highway
Таємне життя пінгвінів↑ペンギン・ハイウェイ|Penguin Highway
Таємне життя пінгвінів↑ペンギン・ハイウェイ|Penguin Highway
Таємнича гра↑Fushigi Yuugi|Mysterious Play|Fushigi Yugi, Curious Play|Mysterious Play|Fushigi Yuugi
Таємнича подружка X↑Nazo no Kanojo X|Mysterious Girlfriend X|MGX|Mysterious Girlfriend X|Nazo no Kanojo X
Таємничі історії Рампо: Гра Лапласа↑乱歩奇譚 Game of Laplace|Rampo Kitan: Game of Laplace
Тваринка↑ペット|Pet
Твоя квітнева брехня↑Shigatsu wa Kimi no Uso|Your Lie in April|Kimiuso|Your Lie in April|Shigatsu wa Kimi no Uso
Твоє ім'я↑Kimi no Na wa.|Your Name.|Your Name.|Kimi no Na wa.|Your Name
Твоє ім'я↑Kimi no Na wa.|Your Name.|Your Name.|Kimi no Na wa.|Your Name
Твоє ім'я↑Kimi no Na wa.|Your Name.|Your Name.|Kimi no Na wa.|Your Name
Твій поцілунок↑KimiKiss Pure Rouge|KimiKiss: Pure Rouge|Kimi-kiss pure rouge|KimiKiss: Pure Rouge|KimiKiss Pure Rouge
Театр мороку↑Yami Shibai|Theatre of Darkness: Yamishibai|Yamishibai: Japanese Ghost Stories|Theatre of Darkness: Yamishibai|Yami Shibai
Театр мороку 2↑Yami Shibai 2|Theatre of Darkness: Yamishibai 2|Yamishibai: Japanese Ghost Stories Second Season, Theater of Darkness 2nd Season|Theatre of Darkness: Yamishibai 2|Yami Shibai 2
Театр мороку 3↑Yami Shibai 3|Theatre of Darkness: Yamishibai 3|Yamishibai: Japanese Ghost Stories Third Season, Theater of Darkness 3rd Season, Japanese Ghost Stories 3|Theatre of Darkness: Yamishibai 3|Yami Shibai 3
Театр мороку 4↑Yami Shibai 4|Theatre of Darkness: Yamishibai 4|Yamishibai: Japanese Ghost Stories Fourth Season, Theater of Darkness 4th Season, Japanese Ghost Stories 4|Theatre of Darkness: Yamishibai 4|Yami Shibai 4
Театр мороку 5↑Yami Shibai 5|Theatre of Darkness: Yamishibai 5|Yamishibai: Japanese Ghost Stories Fifth Season, Theater of Darkness 5th Season, Japanese Ghost Stories 5|Theatre of Darkness: Yamishibai 5|Yami Shibai 5
Театр мороку 7↑Yami Shibai 7|Theatre of Darkness: Yamishibai 7|Yamishibai: Japanese Ghost Stories Seventh Season, Theater of Darkness 7th Season, Japanese Ghost Stories 7|Theatre of Darkness: Yamishibai 7|Yami Shibai 7
Театр мороку 8↑Yami Shibai 8|Theatre of Darkness: Yamishibai 8|Yamishibai: Japanese Ghost Stories Eighth Season, Yamishibai: Japanese Ghost Stories 8|Theatre of Darkness: Yamishibai 8|Yami Shibai 8
Театр мороку 9↑Yami Shibai 9|Theatre of Darkness: Yamishibai 9|Yamishibai: Japanese Ghost Stories Ninth Season, Yamishibai: Japanese Ghost Stories 9|Theatre of Darkness: Yamishibai 9|Yami Shibai 9
Телепат зоряного пилу↑Hoshikuzu Telepath|Stardust Telepath|Hoshitele|Stardust Telepath|Hoshikuzu Telepath
Темна сторона Блюзу↑ダークサイド・ブルース|Darkside Blues
Темне зібрання↑ダークギャザリング|Dark Gathering
Темний Дворецький: Книга Атлантики↑劇場版 黒執事 Book of the Atlantic|Black Butler: Book of the Atlantic
Темний дворецький↑黒執事|Black Butler|Kuro Shitsuji|Kuroshitsuzi
Темний дворецький 2↑Kuroshitsuji II|Black Butler II|Kuroshitsuji 2, Black Butler 2|Black Butler II|Kuroshitsuji II
Темний дворецький 4↑Kuroshitsuji: Kishuku Gakkou-hen|Black Butler: Public School Arc|Black Butler: Public School Edition|Black Butler: Public School Arc|Kuroshitsuji: Kishuku Gakkou-hen
Темний дворецький: Книга цирку↑Kuroshitsuji: Book of Circus|Black Butler: Book of Circus|Kuroshitsuji Circus Hen, Kuroshitsuji Shin Series, Black Butler 3, Kuroshitsuji III|Black Butler: Book of Circus|Kuroshitsuji: Book of Circus
Темніше за Чорне - Історія Чорного Контрактора ОВА↑Darker than Black: Kuro no Keiyakusha Gaiden|Darker Than Black: Gemini of the Meteor OVAs|Darker than Black: Ryuusei no Gemini Specials, Darker than BLACK 2 OVA, DTB, Darker than Black: Ryuusei no Gemini Episode 12|Darker Than Black: Gemini of the Meteor OVAs|Darker than Black: Kuro no Keiyakusha Gaiden
Темніше за Чорне: Близнюки та падаюча зірка↑Darker than Black: Ryuusei no Gemini|Darker than Black: Gemini of the Meteor|Darker than BLACK 2nd Season, Darker than BLACK Second Season, DTB2|Darker than Black: Gemini of the Meteor|Darker than Black: Ryuusei no Gemini
Темніше чорного (ТБ-1)↑Darker than BLACK -黒の契約者-|Darker than Black|DTB
Теніс↑てーきゅう|Teekyu|Tekyuu|Te-kyu
Тераформування↑TERRA FORMARS [テラフォーマーズ]|Terraformars
Технолайз|Техноліз↑TEXHNOLYZE|Texhnolyze|Technolyze
Ти і я↑君と僕。|You and Me|Kimi to Boku
Тибетський пес↑Tibet Inu Monogatari|The Tibetan Dog|Tibetan Dog Story|The Tibetan Dog|Tibet Inu Monogatari
Титанія↑タイタニア|Tytania|Titania|Taitania
Тобі, Безсмертний (1 сезон)↑Fumetsu no Anata e|To Your Eternity|To You, the Immortal|To Your Eternity|Fumetsu no Anata e
Тобі, безсмертний (сезон 2)↑Fumetsu no Anata e Season 2|To Your Eternity Season 2|To Your Eternity 2nd Season, To You, the Immortal 2nd Season|To Your Eternity Season 2|Fumetsu no Anata e Season 2
Товариство Сірокрилих↑灰羽連盟|Haibane Renmei|Charcoal Feather Federation
Той, хто біжить по лезу: Затемнення|Той, хто біжить по лезу: Затемнення 2022↑BLADE RUNNER BLACK OUT 2022|Blade Runner: Black Out 2022
Той, хто біжить по лезу: Чорний лотос↑BLADE RUNNER – BLACK LOTUS|Blade Runner: Black Lotus
Токійський Мармуровий Шоколад↑東京マーブルチョコレート|Tokyo Marble Chocolate|Zenryoku Shounen|Matta Aimashou
Токійський восьмибальний↑東京マグニチュード8.0|Tokyo Magnitude 8.0
Токійський людожер↑東京喰種-トーキョーグール-|Tokyo Ghoul|Tokyo Kushu|Toukyou Kushu|Toukyou Ghoul
Токійський людожер :re (2 сезон)↑東京喰種トーキョーグール：re 第2期|Tokyo Ghoul:re 2nd Season|Tokyo Kushu:re|Toukyou Kuushu:re
Токійський людожер √A↑東京喰種√A|Tokyo Ghoul √A|Tokyo Ghoul Root A|Tokyo Ghoul 2nd Season|Tokyo Ghoul Second Season
Токійський людожер:re (2 сезон)|Токійський людожер:re↑東京喰種トーキョーグール：re|Tokyo Ghoul:re|Tokyo Kushu:re|Toukyou Kuushu:re
Токійський ґуль: Джек↑東京喰種 トーキョーグール【JACK】|Tokyo Ghoul: Jack
Токійський ґуль: Пінто↑東京喰種 トーキョーグール【PINTO】|Tokyo Ghoul: Pinto
Токійський ґуль: Пінто↑東京喰種 トーキョーグール【PINTO】|Tokyo Ghoul: Pinto
Токійський ґуль: Пінто↑東京喰種 トーキョーグール【PINTO】|Tokyo Ghoul: Pinto
Токійські месники (1 сезон)|Токійські месники↑東京リベンジャーズ|Tokyo Revengers
Токійські месники: Арка Тенджіку↑東京リベンジャーズ 天竺編|Tokyo Revengers: Tenjiku-hen
Токійські месники: Арка різдвяної битви (2 сезон)↑Tokyo Revengers: Seiya Kessen-hen|Tokyo Revengers: Christmas Showdown|Tokyo Revengers: Christmas Showdown|Tokyo Revengers: Seiya Kessen-hen
Токійські хресні|Одного разу в Токіо↑東京ゴッドファーザーズ|Tokyo Godfathers
Токійські хресні|Одного разу в Токіо↑東京ゴッドファーザーズ|Tokyo Godfathers
Токійські хресні|Одного разу в Токіо↑東京ゴッドファーザーズ|Tokyo Godfathers
Томо — дівчина!↑トモちゃんは女の子！|Tomo-chan Is a Girl!
Тонкацу DJ Аґетаро↑とんかつDJアゲ太郎|Tonkatsu DJ Agetarou
Торадора!↑とらドラ！|Toradora!|Tiger X Dragon
Торіко↑トリコ|Toriko|Toriko (2011)|Toriko (TV)|Toriko x One Piece Collabo Special
Трансформери: Зона↑トランスフォーマーＺ[ゾーン]|Transformers: Zone|Transformers Z
Трансформери: Мастаки↑トランスフォーマー ザ☆ヘッドマスターズ|Transformers The Headmasters
Триган - розбірки в пустоші↑トライガン|Trigun: Badlands Rumble|Trigun the Movie
Трикутник Аякаші↑あやかしトライアングル|Ayakashi Triangle
Трон ельфів↑Long Zhi Gu: Jingling Wangzuo|Dragon Nest: Throne of Elves|Dragon Nest Movie 2: Throne of Elves|Dragon Nest: Throne of Elves|Long Zhi Gu: Jingling Wangzuo
Троянда Версалю↑ベルサイユのばら|La Rose de Versailles|Versailles no Bara
Трупи під ногами Сакурако↑Sakurako-san no Ashimoto ni wa Shitai ga Umatteiru|Beautiful Bones -Sakurako's Investigation-|A Corpse is Buried Under Sakurako's Feet|Beautiful Bones -Sakurako's Investigation-|Sakurako-san no Ashimoto ni wa Shitai ga Umatteiru
Трусяшка та Панчошка разом з Паском|Панті та Стокінґ з Ґартербелтом↑パンティ＆ストッキングwithガーターベルト|Panty & Stocking with Garterbelt|PanSto|PSG
Тріґан|Тріган|Трайган|Триган|Тріґан / Тріган / Трайган↑トライガン|Trigun
Тріґан Шторм↑TRIGUN STAMPEDE|Trigun Stampede
Тріґан — розбірки у пустці↑トライガン|Trigun: Badlands Rumble|Trigun the Movie
Тріґан — розбірки у пустці↑トライガン|Trigun: Badlands Rumble|Trigun the Movie
Туалетний хлопчик Ханако↑Jibaku Shounen Hanako-kun|Toilet-Bound Hanako-kun|Toilet-Bound Hanako-kun|Jibaku Shounen Hanako-kun
Тунель у літо, прощальний вихід↑夏へのトンネル, さよならの出口|The Tunnel to Summer, the Exit of Goodbyes|Natsuton
Тунель у літо, прощальний вихід↑夏へのトンネル, さよならの出口|The Tunnel to Summer, the Exit of Goodbyes|Natsuton
Тунель у літо, прощальний вихід↑Natsu e no Tunnel, Sayonara no Deguchi|The Tunnel to Summer, the Exit of Goodbyes|Natsuton|The Tunnel to Summer, the Exit of Goodbyes|Natsu e no Tunnel, Sayonara no Deguchi
Тюхталія та країни осі: світ у білих барвах↑銀幕ヘタリア Axis Powers Paint it, White (白くぬれ！)|Hetalia Axis Powers: Paint it, White!|Ginmaku Hetalia: Axis Powers - Paint it|White (Shiroku Nure!)
Тяжке кохання в отаку ОВА↑ヲタクに恋は難しい OAD|Wotakoi: Love is Hard for Otaku OVA|Wotaku ni Koi wa Muzukashii: Youth|It's Difficult to Love an Otaku OVA
Ті, що полюють на ельфів.↑Elf wo Karu Mono-tachi|Those Who Hunt Elves|Those Who Hunt Elves|Elf wo Karu Mono-tachi
Тікай, білий вовче!↑走れ! 白いオオカミ|White Fang|Run! White Wolf|Flight of the White Wolf|Hashire Shiroi Okami
Тіко та друзі↑Nanatsu no Umi no Tico|Tico and Friends|Sekai Meisaku Gekijou, Tico and Nanami|Tico and Friends|Nanatsu no Umi no Tico
Тільки вперед!↑スキップ・ビート！|Skip Beat!
Тільки я візьму новий рівень|Я єдиний піднімаю рівень↑Ore dake Level Up na Ken|Solo Leveling|Na Honjaman Level Up, 나 혼자만 레벨업, I Level Up Alone|Solo Leveling|Ore dake Level Up na Ken
Тінь крокодила↑影鰐-KAGEWANI-|Kagewani
Тінь крокодила: Продовження↑影鰐-KAGEWANI-承|Kagewani -II-
У Комі проблеми зі спілкуванням↑Komi-san wa, Comyushou desu.|Komi Can't Communicate|Komi-san wa, Communication Shougai desu|Komi Can't Communicate|Komi-san wa, Comyushou desu.
У Комі проблеми зі спілкуванням (2 сезон)↑Komi-san wa, Comyushou desu. 2nd Season|Komi Can't Communicate Season 2|Komi-san wa, Communication Shougai desu. 2|Komi Can't Communicate Season 2|Komi-san wa, Comyushou desu. 2nd Season
У Світі Лідейл↑Leadale no Daichi nite|In the Land of Leadale|World of Leadale|In the Land of Leadale|Leadale no Daichi nite
У мене мало друзів: Продовження↑Boku wa Tomodachi ga Sukunai Next|Haganai: I don't have many friends NEXT|Boku wa Tomodachi ga Sukunai 2nd Season|Haganai: I don't have many friends NEXT|Boku wa Tomodachi ga Sukunai Next
У небі сходить місяць↑Hanbun no Tsuki ga Noboru Sora|Looking Up At The Half-Moon|Hantsuki|Looking Up At The Half-Moon|Hanbun no Tsuki ga Noboru Sora
У пекельному вогні палає смуток↑Liehuo Jiao Chou|Drowning Sorrows in Raging Fire|LHJC, Rekka Gyoushuu|Drowning Sorrows in Raging Fire|Liehuo Jiao Chou
У правильному місці↑Right Places: Sono Toki, Boku no Irubeki Basho|Right Places|Right Places|Right Places: Sono Toki, Boku no Irubeki Basho
У серці куноічі Цубакі↑Kunoichi Tsubaki no Mune no Uchi|In the Heart of Kunoichi Tsubaki|Inside Tsubaki Kunoichi's Heart|In the Heart of Kunoichi Tsubaki|Kunoichi Tsubaki no Mune no Uchi
У той час, вона↑その時、カノジョは。|Sono Toki, Kanojo wa.|At That Time|She
У хвості↑テイルエンダーズ|Tailenders
У цій далечіні↑Kono Sekai no Katasumi ni|In This Corner of the World|To All the Corners of the World|In This Corner of the World|Kono Sekai no Katasumi ni
У час, коли плачуть цикади: Епідемія↑Higurashi no Naku Koro ni Kaku: Outbreak|Higurashi: When They Cry - Outbreak|Higurashi: When They Cry - Outbreak|Higurashi no Naku Koro ni Kaku: Outbreak
У час, коли плачуть цикади: Епідемія↑Higurashi no Naku Koro ni Kaku: Outbreak|Higurashi: When They Cry - Outbreak|Higurashi: When They Cry - Outbreak|Higurashi no Naku Koro ni Kaku: Outbreak
У час, коли плачуть цикади: Карма↑Higurashi no Naku Koro ni Gou|Higurashi: When They Cry – Gou|When They Cry, Higurashi: When They Cry - New, Higurashi no Naku Koro ni (2020), When the Cicadas Cry, The Moment the Cicadas Cry|Higurashi: When They Cry – Gou|Higurashi no Naku Koro ni Gou
Убивця Акаме!↑アカメが斬る！|Akame ga Kill!|Akame ga Kiru!
Убивця гоблінів↑ゴブリンスレイヤー|Goblin Slayer
Убивця гоблінів: Корона гобліна|Убивця Гоблінів: Корона Гоблінів↑ゴブリンスレイヤー -GOBLIN'S CROWN-|Goblin Slayer: Goblin's Crown
Убивче кохання↑Koroshi Ai|Love of Kill|Love of Kill|Koroshi Ai
Удаване кохання (1 сезон)↑ニセコイ|Nisekoi: False Love|Nisekoi
Удаване кохання (2 сезон)↑Nisekoi:|Nisekoi: False Love Season 2|Nisekoi 2nd Season|Nisekoi: False Love Season 2|Nisekoi:
Ударні Відьми↑ストライクウィッチーズ|Strike Witches
Ударні Відьми 2↑ストライクウィッチーズ 2|Strike Witches 2
Ударні Відьми 501-ше крило на зліт!↑Strike Witches: 501 Butai Hasshin Shimasu!|Strike Witches: 501st JOINT FIGHTER WING Take Off!|Strike Witches: 501st JOINT FIGHTER WING Take Off!|Strike Witches: 501 Butai Hasshin Shimasu!
Ударні відьми↑ストライクウィッチーズ|Strike Witches
Удзакі хоче гуляти!|Узакі хоче гуляти↑Uzaki-chan wa Asobitai!|Uzaki-chan Wants to Hang Out!|Uzaki-chan Wants to Play!|Uzaki-chan Wants to Hang Out!|Uzaki-chan wa Asobitai!
Узакі хоче гуляти! 2↑宇崎ちゃんは遊びたい！ω（だぶる）|Uzaki-chan Wants to Hang Out! Season 2|Uzaki-chan wa Asobitai! 2nd Season|Uzaki-chan wa Asobitai! ω|Uzaki-chan Wants to Hang Out! 2nd Season|Uzaki-chan Wants to Hang Out! ω
Уламки часу|Фураґутаїму↑フラグタイム|Fragtime|Frag Time|Flagtime|Flag Time
Уламки часу|Фураґутаїму↑フラグタイム|Fragtime|Frag Time|Flagtime|Flag Time
Ультрамен↑钢铁飞龙之再见奥特曼|Gangtie Feilong: Zaijian Ultraman|Dragon Force Movie 2 So long|Ultraman|Dragon Force: Farewell Ultraman|Gang Tie Fei Long: Zai Jian Ao Te Man
Ультрамен 2↑ULTRAMAN|Ultraman Season 2
Ультрамен Фінал↑ULTRAMAN FINAL|Ultraman Final
Улюбленець принцес!↑プリンセスラバー!|Princess Lover!
Улісс. Жанна д'Арк і Лицар-Алхімік↑ユリシーズ ジャンヌ・ダルクと錬金の騎士|Ulysses: Jeanne d'Arc and the Alchemist Knight|Ulysses: Jeanne d'Arc to Renkin no Kishi
Употте!!↑うぽって!!|Upotte!!
Урда, Проект Урда↑ウルダ|Urda|Urda: Third Reich
Усмішка з подіуму↑Runway de Waratte|Smile Down the Runway|Smile at the Runway|Smile Down the Runway|Runway de Waratte
Усі стануть F - ідеальний інсайдер↑すべてがFになる THE PERFECT INSIDER|The Perfect Insider|Everything Becomes F: The Perfect Insider
Ушіо і Тора↑うしおととら|Ushio and Tora|Ushio & Tora
ФЛКЛ↑フリクリ|FLCL|Fooly Cooly|Furi Kuri
ФЛКЛ 2: Проґресів↑フリクリ プログレ|FLCL Progressive|FLCL 2|Fooly Cooly Progressive|Furi Kuri Progressive
ФЛКЛ 2: Проґресів↑フリクリ プログレ|FLCL Progressive|FLCL 2|Fooly Cooly Progressive|Furi Kuri Progressive
ФЛКЛ 2: Проґресів|ФЛКЛ 2↑フリクリ プログレ|FLCL Progressive|FLCL 2|Fooly Cooly Progressive|Furi Kuri Progressive
ФЛКЛ 3: Альтернатива|ФЛКЛ: Альтернатива (Сезон 3)↑フリクリ オルタナ|FLCL Alternative|FLCL 3|Fooly Cooly Alternative|Furi Kuri Alternative
Фабрика ілюзій Аліси та Терези↑Alice to Therese no Maboroshi Koujou|Maboroshi|Alice and Therese's Illusion Factory, The Illusion Factory of Alice and Therese|Maboroshi|Alice to Therese no Maboroshi Koujou
Фабрика ілюзій Аліси та Терези↑Alice to Therese no Maboroshi Koujou|Maboroshi|Alice and Therese's Illusion Factory, The Illusion Factory of Alice and Therese|Maboroshi|Alice to Therese no Maboroshi Koujou
Фамільяр невдахи (1 сезон)↑Zero no Tsukaima|The Familiar of Zero|Zero's Familiar|The Familiar of Zero|Zero no Tsukaima
Фамільяр невдахи: Лицарі Двох Місяців↑Zero no Tsukaima: Futatsuki no Kishi|The Familiar of Zero: Knight of the Twin Moons|Zero's Familiar 2nd Series, Zero no Tsukaima S2, The Familiar of Zero: The Rider of the Twin Moons|The Familiar of Zero: Knight of the Twin Moons|Zero no Tsukaima: Futatsuki no Kishi
Фантазм Йохане: Сонце в дзеркалі↑Genjitsu no Yohane: Sunshine in the Mirror|Yohane the Parhelion: Sunshine in the Mirror|Yohane the Parhelion: Sunshine in the Mirror|Genjitsu no Yohane: Sunshine in the Mirror
Фантазія місячного світла↑Tsuki ga Michibiku Isekai Douchuu|Tsukimichi: Moonlit Fantasy|Moon-led Journey Across Another World|Tsukimichi: Moonlit Fantasy|Tsuki ga Michibiku Isekai Douchuu
Фантазія місячного світла 2↑Tsuki ga Michibiku Isekai Douchuu 2nd Season|Tsukimichi: Moonlit Fantasy Season 2|Tsukimichi: Moonlit Fantasy Season 2|Tsuki ga Michibiku Isekai Douchuu 2nd Season
Фантазія Ґрандблю↑GRANBLUE FANTASY The Animation|Granblue Fantasy: The Animation
Фантастичний світ з перетворенням чоловіка у красуню та…↑異世界美少女受肉おじさんと|Life with an Ordinary Guy who Reincarnated into a Total Fantasy Knockout|Fabiniku|Isekai Bishoujo Juniku Ojisan
Фантастичні діти↑ファンタジックチルドレン|Fantastic Children
Фантом Вбивства: Повстання Зеро↑ファントム オブ キル ―ZEROからの反逆―|Phantom of the Kill: Zero kara no Hangyaku|Phantom of the Kill: Zero's Rebellion
Фантом Вбивства: Повстання Зеро↑ファントム オブ キル ―ZEROからの反逆―|Phantom of the Kill: Zero kara no Hangyaku|Phantom of the Kill: Zero's Rebellion
Фарс з убивством упириці↑アンデッドガール・マーダーファルス|Undead Murder Farce
Фейбл|Байка|Фейбл / Байка↑ザ・ファブル|The Fable
Фермерське життя в іншому світі↑Isekai Nonbiri Nouka|Farming Life in Another World|Farming Life in Another World|Isekai Nonbiri Nouka
Феєрверки↑Uchiage Hanabi, Shita kara Miru ka? Yoko kara Miru ka?|Fireworks|Fireworks, Should We See It from the Side or the Bottom?|Fireworks|Uchiage Hanabi, Shita kara Miru ka? Yoko kara Miru ka?
Фландрійський пес↑超ゼンマイロボ パトラッシュ|Chou Zenmairobo: Patrasche|Flanders no Inu|Chou Zenmai Robo Patrush
Флейта в портфелі: До↑リコーダーとランドセル　ド♪|Recorder and Randsell|Recorder and Backpack Do|Recorder and Satchel Do|Recorder and Randsell Do|Recorder and Ransel Do|Recorder to Randsell Do|Recorder to Ransel Do
Флотська колекція|Кантай колекшн↑Kantai Collection: KanColle|KanColle: Kantai Collection|Kankore|KanColle: Kantai Collection|Kantai Collection: KanColle
Флотська колекція Фільм↑劇場版 艦これ|Fleet Girls Collection KanColle Movie Sequence|Kankore Movie|Gekijouban Kantai Collection
Флотська колекція. Побачимося в морі↑艦これ いつかあの海で|KanColle Season 2: Let's Meet at Sea|KanColle: Someday in that Sea|KanColle 2nd Season|Fleet Girls Collection
Форма голосу↑Koe no Katachi|A Silent Voice|The Shape of Voice|A Silent Voice|Koe no Katachi
Форма голосу↑Koe no Katachi|A Silent Voice|The Shape of Voice|A Silent Voice|Koe no Katachi
Форма голосу↑Koe no Katachi|A Silent Voice|The Shape of Voice|A Silent Voice|Koe no Katachi
Фотоательє↑Shashinkan|The Portrait Studio|The Portrait Studio|Shashinkan
Фрактал↑フラクタル|Fractale
Фрірен, що проводжає в останню путь↑Sousou no Frieren|Frieren: Beyond Journey's End|Frieren at the Funeral|Frieren: Beyond Journey's End|Sousou no Frieren
Фуука↑風夏|Fuuka
Хайді↑Alps no Shoujo Heidi|Heidi: Girl of the Alps|Heidi: Girl of the Alps|Alps no Shoujo Heidi
Хакумей і Мікочі↑ハクメイとミコチ|Hakumei and Mikochi|Tiny Little Life in the Woods
Хал↑ハル|Hal|Haru
Хаматора↑ハマトラ THE ANIMATION|Hamatora The Animation
Хаматора: Перезапис (сезон 2)↑Re:␣ ハマトラ|Re: Hamatora: Season 2|Hamatora The Animation 2nd Season|Reply Hamatora
Ханаан↑CANAAN|Canaan|428: Fuusa Sareta Shibuya de Tokubetsu-hen|428: Fuusasareta Shibuya de Special Chapter|428 the animation
Хананоі-Кун та хвороба кохання↑Hananoi-kun to Koi no Yamai|A Condition Called Love|I'm Addicted to You|A Condition Called Love|Hananoi-kun to Koi no Yamai
Ханда Сей↑はんだくん|Handa-kun
Ханебадо!↑はねバド！|Hanebado!|The Badminton play of Ayano Hanesaki!
Хаос. Розум↑ChäoS;HEAd|ChäoS;HEAd|ChaoS,HEAd|ChäoS;HEAd
Хвіст Феї (2 сезон)↑Fairy Tail (2014)|Fairy Tail Series 2|Fairy Tail Season 2|Fairy Tail Series 2|Fairy Tail (2014)
Хвіст Феї (ОВА)↑フェアリーテイル OVA|Fairy Tail OVA|Fairy Tail: Youkoso Fairy Hills!|Yousei Gakuen: Yankee-kun to Yankee-chan
Хвіст Феї (Сезон 1)↑FAIRY TAIL（フェアリーテイル）|Fairy Tail
Хвіст Феї - Жриця Фенікса↑劇場版 FAIRY TAIL 鳳凰の巫女|Fairy Tail the Movie: The Phoenix Priestess|Gekijouban Fairy Tail: Houou no Miko|Priestess of the Phoenix|Fairy Tail: The Phoenix Priestess
Хвіст Феї - Жриця Фенікса↑劇場版 FAIRY TAIL 鳳凰の巫女|Fairy Tail the Movie: The Phoenix Priestess|Gekijouban Fairy Tail: Houou no Miko|Priestess of the Phoenix|Fairy Tail: The Phoenix Priestess
Хвіст Феї - Жриця Фенікса↑Fairy Tail Movie 1: Houou no Miko|Fairy Tail the Movie: The Phoenix Priestess|Gekijouban Fairy Tail: Houou no Miko, Priestess of the Phoenix, Fairy Tail: The Phoenix Priestess|Fairy Tail the Movie: The Phoenix Priestess|Fairy Tail Movie 1: Houou no Miko
Хвіст Феї: Драконів плач↑劇場版 FAIRY TAIL 『DRAGON CRY』|Fairy Tail the Movie 2: Dragon Cry|Gekijouban Fairy Tail: Dragon Cry
Хвіст Феї: Фінал (3 сезон)↑FAIRY TAIL ファイナルシリーズ|Fairy Tail Final Series|Fairy Tail Season 3|Fairy Tail (2018)
Хеталія: Країни Осі↑ヘタリア Axis Powers|Hetalia Axis Powers
Хеталія: Прекрасний світ↑ヘタリア The Beautiful World|Hetalia: The Beautiful World
Хеталія: Світові зірки↑ヘタリア World★Stars|Hetalia World★Stars
Хибний спосіб використання магії зцілення↑Chiyu Mahou no Machigatta Tsukaikata|The Wrong Way to Use Healing Magic|The Wrong Way to Use Healing Magic|Chiyu Mahou no Machigatta Tsukaikata
Хибні міркування↑Kyokou Suiri|In/Spectre|In/Spectre|Kyokou Suiri
Хибні міркування (2 сезон)↑虚構推理 Season2|In/Spectre 2|In/Spectre 2nd Season|Kyokou Suiri 2nd Season
Хижі ляльки|Ляльки-паразити|Хижі ляльки, Ляльки-паразити↑パラサイトドールズ|Parasite Dolls
Хлопчик і Чудовисько↑バケモノの子|The Boy and the Beast|Child of a Beast
Хлопчик і Чудовисько↑バケモノの子|The Boy and the Beast|Child of a Beast
Хлопчик і Чудовисько↑Bakemono no Ko|The Boy and the Beast|Child of a Beast|The Boy and the Beast|Bakemono no Ko
Хлопчик і чапля↑君たちはどう生きるか|The Boy and the Heron|How Do You Live?
Хлопчик і чапля / Як поживаєте?↑君たちはどう生きるか|The Boy and the Heron|How Do You Live?
Хлопчик, що бачив вітер↑風を見た少年|The Boy Who Saw the Wind|Kaze o Mita Shonen
Хлопчик-покоївка↑少年メイド|Shonen Maid|Boy Maid
Хлопчики-співунці із Каваґое↑川越ボーイズ・シング|Kawagoe Boys Sing -Now or Never-
Хованки|Гра в хованки↑Kakurenbo|Kakurenbo: Hide & Seek|Kakurenbo: Hide & Seek|Kakurenbo
Холоднокровний Хозукі↑Hoozuki no Reitetsu|Hozuki's Coolheadedness|Cool-headed Hoozuki|Hozuki's Coolheadedness|Hoozuki no Reitetsu
Хоробра Яма↑大王不高兴|The Furious Yama|Da Wang Bu Gao Xing
Хорімія↑堀さんと宮村くん|Hori-san to Miyamura-kun|Horimiya
Хорімія. Фрагменти↑Horimiya: Piece|Horimiya: The Missing Pieces|Horimiya: The Missing Pieces|Horimiya: Piece
Хорімія. Хорі та Міямура↑堀さんと宮村くん|Hori-san to Miyamura-kun|Horimiya
Хост-клуб школи Оран|Хост-клуб Оранської школи|Хост клуб школи Оран↑桜蘭高校ホスト部|Ouran High School Host Club|Ohran Koko Host Club|Ouran Koukou Hosutobu|Ouran Koukou Host Bu|OHSHC
Хоторі: я просто хочу щастя↑ほとり～たださいわいを希う|Hotori: Tada Saiwai wo Koinegau
Храм: ніхто не може жити на самоті↑Temple|TenPuru: No One Can Live on Loneliness|TenPuru: No One Can Live on Loneliness|Temple
Хранитель Священного Духу↑Seirei no Moribito|Moribito - Guardian of the Spirit|Guardian of the Sacred Spirit|Moribito - Guardian of the Spirit|Seirei no Moribito
Хрест Анджі. Рондо янгола та дракона↑クロスアンジュ 天使と竜の輪舞〈ロンド〉|Cross Ange: Rondo of Angel and Dragon
Хронос|ХРОНОС↑黒の栖 -Chronus-|Kuro no Su: Chronus|Wakate Animator Ikusei Project|2014 Young Animator Training Project|Anime Mirai 2014|Kuro no Sumika: Chronus
Хроніки Імперії Тіамун↑Tearmoon Teikoku Monogatari: Dantoudai kara Hajimaru, Hime no Tensei Gyakuten Story|Tearmoon Empire|Tearmoon Empire Story|Tearmoon Empire|Tearmoon Teikoku Monogatari: Dantoudai kara Hajimaru, Hime no Tensei Gyakuten Story
Хроніки Акаші, Викладач магії Кретин↑Rokudenashi Majutsu Koushi to Akashic Records|Akashic Records of Bastard Magic Instructor|RokuAka|Akashic Records of Bastard Magic Instructor|Rokudenashi Majutsu Koushi to Akashic Records
Хроніки Валькірії↑Senjou no Valkyria|Valkyria Chronicles|Battlefield Valkyria: Gallian Chronicles|Valkyria Chronicles|Senjou no Valkyria
Хроніки Валькірії 3: Незаписані Хроніки↑戦場のヴァルキュリア3 誰がための銃瘡|Senjou no Valkyria 3: Tagatame no Juusou|Valkyria Chronicles: Unrecorded Chronicles OVA
Хроніки Геда↑ゲド戦記|Tales from Earthsea|Gedo Senki|Tales of Ged|Ged's War Chronicles
Хроніки Геда↑ゲド戦記|Tales from Earthsea|Gedo Senki|Tales of Ged|Ged's War Chronicles
Хроніки Крил↑ツバサ・クロニクル|Tsubasa RESERVoir CHRoNiCLE|Tsubasa: RESERVoir CHRoNiCLE
Хроніки Крил - Принцеса країни пташиної клітки↑ツバサ・クロニクル 鳥カゴの国の姫君|Tsubasa RESERVoir CHRoNiCLE The Movie: The Princess in the Birdcage Kingdom|Tsubasa Chronicle the Movie: The Princess of the Country of Birdcages|Tsubasa Chronicle: Princess of the Country of the Birdcages
Хроніки дванадцяти королівств↑十二国記|The Twelve Kingdoms|12 Kingdoms|Juuni Kokki
Хроніки молодят↑ふたりエッチ|Step Up Love Story|Futari H
Хроніки непереможного Бахамута|Хроніки непереможного Багамута|Хроніки непереможного Багамута (Бахамута)↑最弱無敗の神装機竜《バハムート》|Undefeated Bahamut Chronicle|Saijaku Muhai no Bahamut
Хроніки Ґеда↑ゲド戦記|Tales from Earthsea|Gedo Senki|Tales of Ged|Ged's War Chronicles
Хтива Ао не може навчатись↑Midara na Ao-chan wa Benkyou ga Dekinai|Ao-chan Can't Study!|Ao-chan Can't Study!|Midara na Ao-chan wa Benkyou ga Dekinai
Хтивий Хвіст Фандабу: зимовий спешл↑Fairy Tail OVA (2016)|Fairy Tail Series 2 OVA|Fairies' Penalty Game, Natsu vs. Mavis, Fairies' Christmas|Fairy Tail Series 2 OVA|Fairy Tail OVA (2016)
Хтивий метелик: Воїн у спідньому↑ランジェリー戦士パピヨンローゼ|Papillon Rose OVA|Lingerie Soldier Papillon Rose
Художній альбом↑スケッチブック ～full color's～|Sketchbook ~full color's~
Хьока↑氷菓|Hyouka|Hyou-ka|Hyouka: You can't escape|Hyou-ka: You can't escape|Hyoka
Хіба я не просила зробити мої Здібності у наступному житті Посередніми?!↑Watashi, Nouryoku wa Heikinchi de tte Itta yo ne!|Didn't I Say to Make My Abilities Average in the Next Life?!|Noukin|Didn't I Say to Make My Abilities Average in the Next Life?!|Watashi, Nouryoku wa Heikinchi de tte Itta yo ne!
Хікару та Ґо↑ヒカルの碁|Hikaru no Go|Hikaru's Go
Хімоте Хаус↑Himote House|HIMOTE HOUSE: A share house of super psychic girls|HIMOTE HOUSE: A share house of super psychic girls|Himote House
Хісоне та Масотан↑ひそねとまそたん|Dragon Pilot: Hisone and Masotan|Hisone & Masotan|Hisone and Maso-tan|HisoMaso
Це моє життя↑IT'S MY LIFE|It's My Life
Це провина не моя, що непопулярна я!|Це провина не моя, що не популярна я!↑私がモテないのはどう考えてもお前らが悪い!|WataMote: No Matter How I Look At It, It's You Guys' Fault I'm Not Popular!|Watashi ga Motenai no wa Dou Kangaete mo Omaera ga Warui!|It's Not My Fault That I'm Not Popular!|WataMote
Це що, зомбі?↑これはゾンビですか?|Is This a Zombie?|Koreha Zombie Desuka?|Kore ha Zombie Desu ka?|Kore wa Zombie Desuka?
Це що, зомбі? Серед мерців↑これはゾンビですか? OF THE DEAD|Is This a Zombie? of the Dead|Kore wa Zombie Desu ka? 2|Koreha Zombie Desu ka? Jigokuhen|Kore ha Zombie Desu ka? Jigokuhen|Kore wa Zombie Desu ka? Jigokuhen|Kore wa Zombie Desuka? of the Dead
Цей герой надмогутній, але занадто обережний↑慎重勇者 ～この勇者が俺TUEEEくせに慎重すぎる～|Cautious Hero: The Hero Is Overpowered but Overly Cautious|Shinchou Yuusha: Kono Yuusha ga Ore Tsueee Kuse ni Shinchou Sugiru
Цей прекрасний світ, благословенний Богом! (1 сезон)↑Kono Subarashii Sekai ni Shukufuku wo!|KonoSuba: God's Blessing on This Wonderful World!|Give Blessings to This Wonderful World!|KonoSuba: God's Blessing on This Wonderful World!|Kono Subarashii Sekai ni Shukufuku wo!
Цей прекрасний світ, благословенний Богом! (2 сезон)↑Kono Subarashii Sekai ni Shukufuku wo! 2|KonoSuba: God's Blessing on This Wonderful World! 2|Give Blessings to This Wonderful World! 2|KonoSuba: God's Blessing on This Wonderful World! 2|Kono Subarashii Sekai ni Shukufuku wo! 2
Цей прекрасний світ, благословенний Богом! Багряна легенда↑映画 この素晴らしい世界に祝福を！紅伝説|KonoSuba: God's Blessing on This Wonderful World! - Legend of Crimson|KonoSuba Movie|Eiga Kono Subarashii Sekai ni Shukufuku wo!
Цей прекрасний світ, благословенний Богом! Багряна легенда↑映画 この素晴らしい世界に祝福を！紅伝説|KonoSuba: God's Blessing on This Wonderful World! - Legend of Crimson|KonoSuba Movie|Eiga Kono Subarashii Sekai ni Shukufuku wo!
Цей прекрасний світ, благословенний Богом! Багряна легенда↑Kono Subarashii Sekai ni Shukufuku wo! Movie: Kurenai Densetsu|KonoSuba: God's Blessing on This Wonderful World! - Legend of Crimson|KonoSuba Movie, Eiga Kono Subarashii Sekai ni Shukufuku wo!|KonoSuba: God's Blessing on This Wonderful World! - Legend of Crimson|Kono Subarashii Sekai ni Shukufuku wo! Movie: Kurenai Densetsu
Цей прекрасний світ, благословенний богом! 3↑Kono Subarashii Sekai ni Shukufuku wo! 3|KonoSuba: God's Blessing on This Wonderful World! 3|KonoSuba: God's Blessing on This Wonderful World! 3|Kono Subarashii Sekai ni Shukufuku wo! 3
Цей прекрасний світ, благословенний вибухом!↑Kono Subarashii Sekai ni Bakuen wo!|KonoSuba: An Explosion on This Wonderful World!|KonoSuba: An Explosion on This Wonderful World!|Kono Subarashii Sekai ni Bakuen wo!
Цей світ, відомий тільки Богу↑Kami nomi zo Shiru Sekai|The World God Only Knows|Kaminomi|The World God Only Knows|Kami nomi zo Shiru Sekai
Цикл Обезголовлювання: Блакитний Савант і Слуга Маячні↑Kubikiri Cycle: Aoiro Savant to Zaregotozukai|The Kubikiri Cycle|Zaregoto Series, The Headless Cycle, The Beheading Cycle: The Blue Savant and the Nonsense Bearer|The Kubikiri Cycle|Kubikiri Cycle: Aoiro Savant to Zaregotozukai
Цитрус↑Citrus|Citrus (Music)
Цубаса та світлячки↑つばさとホタル|Tsubasa to Hotaru|Ribon Festa 2014|Ribbon Festa 2014|Tsubasa and Hotaru
Цукровий солдатик↑シュガー＊ソルジャー|Sugar*Soldier|Sugar Soldier|Sugar * Soldier|Ribbon x Oha Suta Specials|Ribon x Oha Suta Specials
Цуруне. Єднальний постріл↑Tsurune: Tsunagari no Issha|Tsurune - The Linking Shot -|Tsurune 2nd Season|Tsurune - The Linking Shot -|Tsurune: Tsunagari no Issha
Цуруне. Клуб кюдо старшої школи Кадземай↑Tsurune: Kazemai Koukou Kyuudou-bu|Tsurune: Kazemai High School Kyudo Club|Tsurune: Kazemai High School Kyudo Club|Tsurune: Kazemai Koukou Kyuudou-bu
Цуруне. Перший постріл↑Tsurune Movie: Hajimari no Issha|Tsurune the Movie: The First Shot|Tsurune the Movie: The First Shot|Tsurune Movie: Hajimari no Issha
Ця нещодавно найнята покоївка підозріла↑Saikin Yatotta Maid ga Ayashii|The Maid I Hired Recently Is Mysterious|My Recently Hired Maid is Suspicious|The Maid I Hired Recently Is Mysterious|Saikin Yatotta Maid ga Ayashii
Ця фарфорова лялечка закохалася↑その着せ替え人形は恋をする|My Dress-Up Darling|Sono Kisekae Ningyou wa Koi wo Suru|KiseKoi
Ці нестерпні прибульці↑うる星やつら|Urusei Yatsura|Those Obnoxious Aliens|The Return of Lum|Lum|the Invader Girl
Чайка - Принцеса з труною↑Hitsugi no Chaika|Chaika -The Coffin Princess-|Hitsugi Hime no Chaika|Chaika -The Coffin Princess-|Hitsugi no Chaika
Чайка - Принцеса з труною: Битва заради помсти (2 сезон)↑棺姫のチャイカ AVENGING BATTLE|Chaika -The Coffin Princess- Avenging Battle|Hitsugi no Chaika 2nd Season|Hitsugi no Chaika Second Season
Чарівна дівчинка Оре↑Mahou Shoujo Ore|Magical Girl Ore|Magical Girl Me|Magical Girl Ore|Mahou Shoujo Ore
Чарівна подорож маленького Нільса Гольґерсона з дикими гусьми↑ニルスのふしぎな旅|The Wonderful Adventures of Nils Movie|Nils no Fushigi na Tabi|Nirusu no Fushigi na Tabi|The Wonderful Adventures of Nils: The Film|Wonderful Adventures of Nils (Movie)
Чарівна, як Місяць|Місяць прекрасний↑月がきれい|Tsukigakirei|The Moon is Beautiful|As the Moon|So Beautiful
Чарівний Семпай|Фокусниця-старшокласниця↑Tejina-senpai|Magical Sempai|Magical Sempai|Tejina-senpai
Чарівник крижаного клинка правитиме світом↑Hyouken no Majutsushi ga Sekai wo Suberu|The Iceblade Sorcerer Shall Rule the World|The Iceblade Sorcerer Shall Rule the World|Hyouken no Majutsushi ga Sekai wo Suberu
Чарівниця Мадока Магіка↑魔法少女まどか★マギカ|Puella Magi Madoka Magica|Mahou Shoujo Madoka Magika|Magical Girl Madoka Magica
Чарівниця Мадока Маґіка Фільм 1: Початок↑Mahou Shoujo Madoka★Magica Movie 1: Hajimari no Monogatari|Puella Magi Madoka Magica the Movie Part 1: Beginnings|Mahou Shoujo Madoka Magika Movie 1, Magical Girl Madoka Magica Movie 1|Puella Magi Madoka Magica the Movie Part 1: Beginnings|Mahou Shoujo Madoka★Magica Movie 1: Hajimari no Monogatari
Чарівниця Мадока Маґіка Фільм 2: Історія вічності↑劇場版 魔法少女まどか☆マギカ 永遠の物語|Puella Magi Madoka Magica the Movie Part 2: Eternal|Mahou Shoujo Madoka Magika Movie 2|Magical Girl Madoka Magica Movie 2
Чарівниця Мадока Маґіка Фільм 3: Історія повстання↑Mahou Shoujo Madoka★Magica Movie 3: Hangyaku no Monogatari|Puella Magi Madoka Magica the Movie: Rebellion|Mahou Shoujo Madoka Magika Movie 3, Magical Girl Madoka Magica Movie 3|Puella Magi Madoka Magica the Movie: Rebellion|Mahou Shoujo Madoka★Magica Movie 3: Hangyaku no Monogatari
Час Єви↑Eve no Jikan (Movie)|Time of Eve|Eve's Time, Eve no Jikan 1st Season Complete Edition, Gekijouban Eve no Jikan|Time of Eve|Eve no Jikan (Movie)
Час Ібларда↑イバラード時間|Iblard Jikan|Iblard Time
Час ніндзя↑忍の一時|Shinobi no Ittoki
Чекаємо на тебе влітку↑Ano Natsu de Matteru|Waiting in the Summer|Waiting in the Summer|Ano Natsu de Matteru
Червона межа↑REDLINE|Redline|Red line
Червона межа↑REDLINE|Redline|Red line
Червона межа↑REDLINE|Redline|Red line
Червоний Марс↑MARS RED|Mars Red
Черепоголовий продавець книг Хонда↑Gaikotsu Shotenin Honda-san|Skull-face Bookseller Honda-san|Skull-face Bookseller Honda-san|Gaikotsu Shotenin Honda-san
Чи готовий ти закохатись у збоченку, якщо вона мила?↑Kawaikereba Hentai demo Suki ni Natte Kuremasu ka?|Hensuki: Are you willing to Fall in Love with a Pervert, as long as she's a Cutie?|Would you love a pervert as long as she's cute?|Hensuki: Are you willing to Fall in Love with a Pervert, as long as she's a Cutie?|Kawaikereba Hentai demo Suki ni Natte Kuremasu ka?
Чи неправильно, шукати дівчину в підземеллі?↑Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka OVA|Is It Wrong to Try to Pick Up Girls in a Dungeon?: Is It Wrong to Expect a Hot Spring in a Dungeon?|DanMachi OVA, Is It Wrong to Try to Pick Up Girls in a Dungeon? OVA, Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka: Dungeon ni Onsen wo Motomeru no wa Machigatteiru Darou ka|Is It Wrong to Try to Pick Up Girls in a Dungeon?: Is It Wrong to Expect a Hot Spring in a Dungeon?|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka OVA
Чи неправильно, шукати дівчину в підземеллі? ОВА↑ダンジョンに出会いを求めるのは間違っているだろうか OVA「ダンジョンに温泉を求めるのは 間違っているだろうか」|Is It Wrong to Try to Pick Up Girls in a Dungeon?: Is It Wrong to Expect a Hot Spring in a Dungeon?|DanMachi OVA|Is It Wrong to Try to Pick Up Girls in a Dungeon? OVA|Dungeon ni Deai wo Motomeru no wa Machigatteiru Darou ka: Dungeon ni Onsen wo Motomeru no wa Machigatteiru Darou ka
Чи справді я найсильніший?↑Jitsu wa Ore, Saikyou deshita?|Am I Actually the Strongest?|Am I Actually the Strongest?|Jitsu wa Ore, Saikyou deshita?
Чиста романтика (ТБ-1)|Чиста романтика↑純情ロマンチカ|Junjo Romantica|Junjyou Romantica|Junjou Romantica: Pure Romance
Чиста романтика (ТБ-2)↑純情ロマンチカ2(に)|Junjo Romantica 2|Junjou Romantica Second Season|Junjyou Romantica II
Чиста романтика (ТБ-3)↑純情ロマンチカ 3|Junjo Romantica 3|Junjou Romantica Third Season
Чистий звук↑Mashiro no Oto|Those Snow White Notes|Those Snow White Notes|Mashiro no Oto
Читерські скіли в ісекаї зробили мене імбою в реалі↑Isekai de Cheat Skill wo Te ni Shita Ore wa, Genjitsu Sekai wo mo Musou Suru: Level Up wa Jinsei wo Kaeta|I Got a Cheat Skill in Another World and Became Unrivaled in The Real World, Too|Iseleve|I Got a Cheat Skill in Another World and Became Unrivaled in The Real World, Too|Isekai de Cheat Skill wo Te ni Shita Ore wa, Genjitsu Sekai wo mo Musou Suru: Level Up wa Jinsei wo Kaeta
Члени Учнівської ради↑Seitokai Yakuindomo|Student Council Staff Members|SYD|Student Council Staff Members|Seitokai Yakuindomo
Чобіти↑ちょびっツ|Chobits
Чому ви тут, учителько?!|Чому ви тут, учителько!?↑Nande Koko ni Sensei ga!?|Why the Hell are You Here, Teacher!?|Nankoko|Why the Hell are You Here, Teacher!?|Nande Koko ni Sensei ga!?
Чорна Лагуна: Кривава стежка Роберти|Чорна Лагуна – Кривава стежка Роберти↑BLACK LAGOON Roberta's Blood Trail|Black Lagoon: Roberta's Blood Trail|Black Lagoon 3
Чорна Лисиця↑黑盒|Undetectable Box|Black Box
Чорна конюшина↑ブラッククローバー|Black Clover
Чорна конюшина: Меч короля магів↑ブラッククローバー 魔法帝の剣|Black Clover: Sword of the Wizard King|Black Clover: Mahoutei no Ken
Чорна конюшина: Меч короля магів↑ブラッククローバー 魔法帝の剣|Black Clover: Sword of the Wizard King|Black Clover: Mahoutei no Ken
Чорна куля↑ブラック・ブレット　BLACK BULLET　［黒の銃弾］|Black Bullet
Чорна магія M-66|Чорна магія M – 66↑ブラックマジックＭ（マリオ）－６６|Black Magic M-66|Black Magic M66|Black Magic Mario 66
Чорна магія M-66|Чорна магія M – 66↑ブラックマジックＭ（マリオ）－６６|Black Magic M-66|Black Magic M66|Black Magic Mario 66
Чорна магія M-66|Чорна магія M – 66↑Black Magic M-66|Black Magic M-66|Black Magic M66, Black Magic Mario 66|Black Magic M-66
Чорний Кам'яний Стрілець↑ブラック★ロックシューター|Black Rock Shooter|BRS (TV)
Чорний Кам'яний Стрілець ОВА↑ブラック★ロックシューター|Black★Rock Shooter (OVA)|BRS OVA
Чорний заклинатель↑Kuro no Shoukanshi|Black Summoner|The Berserker Rises to Greatness|Black Summoner|Kuro no Shoukanshi
Чорний кіт Рудольф↑ルドルフとイッパイアッテナ|Rudolf the Black Cat|Rudolph and Ippaiattena
Чотири ритми по той бік блакиті↑Ao no Kanata no Four Rhythm|Aokana: Four Rhythm Across the Blue|Aokana|Aokana: Four Rhythm Across the Blue|Ao no Kanata no Four Rhythm
Чотири сезони↑The Four Seasons
Чудові Дні↑Wonderful Days|Sky Blue|Sky Blue|Wonderful Days
Чуйний погляд|Чийсь погляд|Чийсь пильний погляд↑Dareka no Manazashi|Someone's Gaze|Someone's Gaze|Dareka no Manazashi
Чуйний погляд|Чийсь погляд|Чийсь пильний погляд↑Dareka no Manazashi|Someone's Gaze|Someone's Gaze|Dareka no Manazashi
Чюнібьо теж хочуть кохати! (1 сезон)↑Chuunibyou demo Koi ga Shitai!|Love, Chunibyo & Other Delusions!|Chu-2 Byo demo Koi ga Shitai!, Regardless of My Adolescent Delusions of Grandeur, I Want a Date!|Love, Chunibyo & Other Delusions!|Chuunibyou demo Koi ga Shitai!
Чібі Єва - Євангеліон у школі↑ぷちえう゛ぁ|Petit Eva: Evangelion@School|Puchi Eva|Eva-School|EAS|EOS|Neon Genesis Evangelion @ School
Чіо: дорога до школи↑Chio-chan no Tsuugakuro|Chio's School Road|Chio's School Road|Chio-chan no Tsuugakuro
Чіхая↑ちはやふる|Chihayafuru|Chihayafull
Шалений Танець Мечів↑活撃／刀剣乱舞|Katsugeki Touken Ranbu
Шалений азарт↑賭ケグルイ|Kakegurui|Kakegurui: Compulsive Gambler|Gambling School
Шалений азарт ХХ↑賭ケグルイ××|Kakegurui××|Kakegurui 2nd Season|Kakegurui: Compulsive Gambler 2nd Season|Gambling School 2nd Season
Шарлота↑Charlotte（シャーロット）|Charlotte
Шахрай: за мотивами 'Юнацького детективного агентства' Едоґави Рампо↑Trickster: Edogawa Ranpo "Shounen Tanteidan" yori|Trickster|Trickster|Trickster: Edogawa Ranpo "Shounen Tanteidan" yori
Шахрайське ремесло↑チーティングクラフト|Cheating Craft|Zuobi Yishu
Шепіт серця|Якщо прислухатись|(Якщо прислухатись)↑耳をすませば|Whisper of the Heart|If You Listen Carefully|Ghibli Movie 10
Шепіт серця|Якщо прислухатись|(Якщо прислухатись)↑Mimi wo Sumaseba|Whisper of the Heart|If You Listen Carefully, Ghibli Movie 10|Whisper of the Heart|Mimi wo Sumaseba
Школа під нападом↑ねらわれた学園|Psychic School Wars
Школа під нападом↑ねらわれた学園|Psychic School Wars
Школа під нападом↑Nerawareta Gakuen|Psychic School Wars|Psychic School Wars|Nerawareta Gakuen
Школа-в'язниця↑監獄学園〈プリズンスクール〉|Prison School|Kangoku Gakuen
Шкільна любов↑徒然チルドレン|Tsuredure Children
Шкільна форма Акебі↑Akebi-chan no Sailor-fuku|Akebi's Sailor Uniform|Akebi's Sailor Uniform|Akebi-chan no Sailor-fuku
Шкільне життя!↑がっこうぐらし！|School-Live!|Gakkou Gurashi!
Шкільні війни↑Ikkitousen|Ikki Tousen: Battle Vixens|Ikki-Tosen: Legendary Fighter, Battle Vixens|Ikki Tousen: Battle Vixens|Ikkitousen
Шкільні дні↑スクールデイズ|School Days
Шлях Валькірії: Русалка↑ヴァルキリードライヴ　マーメイド|Valkyrie Drive: Mermaid
Шлях до тебе↑ROAD TO YOU|Road to You|Road to You: The Road That Goes on to You|Road to You: Promise of the Starry Hill|Road to You: The Snow That Dances in Memories|Road to You: Kimi e to Tsuzuku Michi|Road to You: Hoshifuru Oka no Yakusoku|Road to You: Kioku ni Mau Konayuki
Шлях домогосподаря↑Gokushufudou|The Way of the Househusband|The Way of the House Husband, Yakuza goes Houseman|The Way of the Househusband|Gokushufudou
Шлях юності↑Ao Haru Ride|Blue Spring Ride|Aoharaido|Blue Spring Ride|Ao Haru Ride|Blue Spring Ride
Шматуй!↑Bucchigire!|Shine On! Bakumatsu Bad Boys|Shine On! Bakumatsu Bad Boys|Bucchigire!|Shine On! Bakumatsu Bad Boys
Шоколад купідона (2 сезон)↑愛神巧克力 2期|Cupid’s Chocolates II|Cupid's Chocolates 2nd Season|Aishen Qiaokeli Jinxingshi 2nd Season
Шпигунський клас↑スパイ教室|Spy Classroom|Spy Room
Шпигунський клас 2↑スパイ教室|Spy Classroom Season 2|Spy Room 2
Штейнова Брама 0|Брама;Штейна 0|Штейнова Брама 0 / Брама;Штейна 0↑シュタインズ・ゲート ゼロ|Steins;Gate 0|Steins|Gate Zero
Шікіморі не лише мила↑可愛いだけじゃない式守さん|Shikimori's Not Just a Cutie|Shikimori's Not Just a Cutie, Miss Shikimori is not just cute, That Girl Is Not Just Cute
Шінко з чуприною і Тисячолітня Магія↑マイマイ新子と千年の魔法|Mai-Mai Miracle|Mai Mai Shinko and the Millennium-Old Magic
Шінко з чуприною і Тисячолітня Магія↑マイマイ新子と千年の魔法|Mai-Mai Miracle|Mai Mai Shinko and the Millennium-Old Magic
Шінко з чуприною і Тисячолітня Магія↑マイマイ新子と千年の魔法|Mai-Mai Miracle|Mai Mai Shinko and the Millennium-Old Magic
Шіґофумі: Листи з потойбіччя↑シゴフミ|Shigofumi: Letters from the Departed|Shigofumi: Stories of Last Letter
Шіґуруй↑シグルイ|Shigurui: Death Frenzy|Crazy for Death
Щаслива Зірка↑らき☆すた|Lucky☆Star|Lucky Star
Щасливе солодке життя↑ハッピーシュガーライフ|Happy Sugar Life|White Sugar Garden|Black Salt Cage
Ще одне майбутнє↑もうひとつの未来を.|A.U.F.L. : au Unlimited Future Laboratory|Mou Hitotsu no Mirai o
Щирі Сльози↑true tears|True Tears Epilogue
Щоденна криза↑バブルガムクライシス|Bubblegum Crisis|Bubblegum Crisis 2032|Bubblegum Crisis 2033
Щоденник Анни Франк↑アンネの日記|The Diary of Anne Frank
Щоденник Очібі↑オチビサン|Ochibi-san
Щоденник Пойо↑ポヨポヨ観察日記|Poyopoyo
Щоденник Тортова Роддла↑或る旅人の日記|A Traveller's Diary|The Diary of Tortov Roddle
Щоденник майбутнього↑未来日記|The Future Diary|Mirai Nikki|Mirai Nikki (2011)
Щоденник майбутнього ОВА↑未来日記|The Future Diary|Mirai Nikki|Mirai Nikki (2011)
Щоденник спостережень Ятогамочки↑八十亀ちゃんかんさつにっき|Yatogame-chan Kansatsu Nikki
Щоденник спостережень Ятогамочки 2↑八十亀ちゃんかんさつにっき 2さつめ|Yatogame-chan Kansatsu Nikki 2|Yatogame-chan Kansatsu Nikki 2nd Season|Yatogame-chan Kansatsu Nikki Second Season|Yatogame-chan Kansatsu Nikki 2-satsume
Ю-Гі-О! Покоління X↑遊☆戯☆王　デュエルモンスターズ GX|Yu-Gi-Oh! GX|Yugioh GX|Yu-Gi-Oh! Genex|Yugioh Genex|Yu-Gi-Oh!: Duel Monsters GX|Yugioh: Duel Monsters GX|Yu-Gi-Oh!: Duel Monsters Genex|Yugioh: Duel Monsters Genex|Game King of Duel Monsters GX
Юна з маєтку Юраґі|Юна з маєтку Юрагі↑ゆらぎ荘の幽奈さん|Yuuna and the Haunted Hot Springs|Yuuna of Yuragi Manor
Юно: дівчина, яка оспівує кохання на межі цього світу↑この世の果てで恋を唄う少女YU-NO|YU-NO: A Girl Who Chants Love at the Bound of This World|Yuno
Юні принцеси. Райська любов↑ベイビー・プリンセス 3Dぱらだいす0[ラブ]|Baby Princess 3D Paradise 0 [Love]|Baby Princess 2D Paradise Love
Юрі на льоду!↑ユーリ!!! on ICE|Yuri!!! On ICE
Юрі – моя робота!↑私の百合はお仕事です！|Yuri is My Job!|Schwestern in Liebe!, Watayuri
Я Архідемон, що взяв рабиню Ельфійку в дружини↑魔王の俺が奴隷エルフを嫁にしたんだが、どう愛でればいい？|An Archdemon's Dilemma: How to Love Your Elf Bride|I, the Demon Lord, Took a Slave Elf as My Wife, but How Do I Love Her?, Madome
Я буду Хвостики Носити↑俺、ツインテールになります。|Gonna be the Twin-Tail!!|Ore, Twin tails ni Narimasu
Я закохалася у Лиходійку↑私の推しは悪役令嬢。|I'm in Love with the Villainess|I'm in Love with the Villainess, WataOshi
Я захоплююся чарівними дівчатками, та..|Я захоплююся чарівними дівчатами і...↑魔法少女にあこがれて|Gushing over Magical Girls|Mahoako, Looking up to Magical Girls, I Admire Magical Girls, and
Я збираю 80 тисяч золотих на безбідну старість↑老後に備えて異世界で８万枚の金貨を貯めます|Saving 80,000 Gold in Another World for My Retirement|Roukin
Я знайшла це в Шічіґахамі↑七ヶ浜でみつけた|I Found it in Shichigahama
Я навчаю врятовану панянку, чиї заручини скасували, як бути неслухняною↑婚約破棄された令嬢を拾った俺が、イケナイことを教え込む|I'm Giving the Disgraced Noble Lady I Rescued a Crash Course in Naughtiness|Ikenaikyo
Я не можу зрозуміти, про що говорить мій чоловік (1 сезон)↑旦那が何を言っているかわからない件|I Can't Understand What My Husband Is Saying|Danna ga Nani wo Itteiru ka Wakaranai Ken
Я не можу зрозуміти, про що говорить мій чоловік (2 сезон)↑旦那が何を言っているかわからない件2スレ目|I Can't Understand What My Husband Is Saying: 2nd Thread|Danna ga Nani wo Itteiru ka Wakaranai Ken 2nd Season, I Can't Understand What My Husband Is Saying Second Season
Я не став героєм, тож гарую на роботі↑勇者になれなかった俺はしぶしぶ就職を決意しました。|I Couldn`t Become a Hero, So I Reluctantly Decided to Get a Job|Yu-sibu, Yusibu, Yuushibu
Я павучиха, то й що?↑蜘蛛ですが、なにか？|So I'm a Spider, So What?
Я переродився в торговий автомат і тепер блукаю підземеллям↑自動販売機に生まれ変わった俺は迷宮を彷徨う|Reborn as a Vending Machine, I Now Wander the Dungeon|I Was Reborn as a Vending Machine, Wandering in the Dungeon, I Reincarnated Into a Vending Machine, Orejihanki
Я переродилася в отоме-грі у ролі лиходійки: всі рути ведуть до погибелі|Я переродилася в отоме гейм у ролі лиходійки. Усі рути ведуть до погибелі...↑乙女ゲームの破滅フラグしかない悪役令嬢に転生してしまった…|My Next Life as a Villainess: All Routes Lead to Doom!|Hamefura, I Reincarnated into an Otome Game as a Villainess With Only Destruction Flags…, Destruction Flag Otome
Я поголився. А потім привів додому старшокласницю.↑ひげを剃る。そして女子高生を拾う。|Higehiro: After Being Rejected, I Shaved and Took in a High School Runaway|I Shaved. Then I Brought a High School Girl Home., Higehiro
Я стою на мільйоні трупів↑100万の命の上に俺は立っている|I'm Standing on a Million Lives|I'm standing on 1,000,000 lives
Я стою на мільйоні трупів (Сезон 2)↑100万の命の上に俺は立っている|I’m Standing on a Million Lives Season 2|I'm standing on 1,000,000 lives. Season 2
Я хочу з'їсти твою підшлункову↑君の膵臓をたべたい|I Want To Eat Your Pancreas|KimiSui, Let Me Eat Your Pancreas
Я хочу з'їсти твою підшлункову↑君の膵臓をたべたい|I Want To Eat Your Pancreas|KimiSui, Let Me Eat Your Pancreas
Я хочу з'їсти твою підшлункову↑君の膵臓をたべたい|I Want To Eat Your Pancreas|KimiSui, Let Me Eat Your Pancreas
Я хочу стати п'ятою↑５等になりたい。|Gotou ni Naritai.|5-tou ni Naritai
Я чую море↑海がきこえる|The Ocean Waves|I Can Hear the Sea
Я чую море↑海がきこえる|The Ocean Waves|I Can Hear the Sea
Я чую море↑海がきこえる|The Ocean Waves|I Can Hear the Sea
Я — Сакамото, втямили?↑坂本ですが？|Haven't You Heard? I'm Sakamoto|Sakamoto desu ga?
Я, Цушіма↑俺、つしま|I, Tsushima|I am Tsushima
Яблучне зерня: проект Альфа↑Appleseed Alpha|Appleseed Alpha|Project Alpha|Appleseed α
Яблучне зерня: проект Альфа↑Appleseed Alpha|Project Alpha|Appleseed α
Яблучне зернятко|Яблучне насіння|Яблучне зерня↑アップル・シード|Appleseed
Яблучне зернятко|Яблучне насіння|Яблучне зерня↑アップル・シード|Appleseed
Яблучне зернятко|Яблучне насіння|Яблучне зерня↑アップル・シード|Appleseed
Яблучне зернятко|Яблучне насіння|Яблучне зерня|Яблучне зернятко / Яблучне насіння↑アップル・シード|Appleseed
Яблучне зернятко|Яблучне насіння|Яблучне зерня↑アップル・シード|Appleseed
Яблучне зернятко|Яблучне насіння|Яблучне зерня↑アップル・シード|Appleseed
Яблучне насіння XIII↑アップルシード XIII|Appleseed XIII|Appleseed (2011)
Яйце Ангела|Яйце Янгола|Яйце ангела↑天使のたまご|Angel's Egg
Яйце Ангела|Яйце Янгола↑天使のたまご|Angel's Egg
Яйце Ангела|Яйце Янгола|Яйце Ангела / Яйце Янгола↑天使のたまご|Angel's Egg|Tenshi no Tamago / Angel's Egg
Яйця Дракона|Перли дракона↑龙珠寻游记|Longzhu Xun Youji|Dragon Ball
Яйця Дракона: Прокляття кривавих рубінів↑ドラゴンボール 神龍の伝説|Dragon Ball: Curse of the Blood Rubies
Яйця Дракона: Прокляття кривавих рубінів↑ドラゴンボール 神龍の伝説|Dragon Ball: Curse of the Blood Rubies
Як вести бій↑喧嘩独学|Viral Hit|Ssaumdokhak, How to Fight, 싸움독학
Як виростити героїню зі звичайної дівчини↑冴えない彼女〈ヒロイン〉の育てかた|Saekano: How to Raise a Boring Girlfriend|Saenai Kanojo no Sodate-kata
Як герой-реаліст перебудовує королівство↑現実主義勇者の王国再建記|How a Realist Hero Rebuilt the Kingdom|Re:Construction the Elfrieden Kingdom Tales of Realistic Brave, A Realist Hero's Kingdom Restoration Chronicle, Genkoku
Як герой-реаліст перебудовує королівство 2↑現実主義勇者の王国再建記|How a Realist Hero Rebuilt the Kingdom Part 2|Re:Construction the Elfrieden Kingdom Tales of Realistic Brave, A Realist Hero's Kingdom Restoration Chronicle
Як квітнуть квіти↑花咲くいろは|Hanasaku Iroha: Blossoms for Tomorrow
Як квітнуть квіти. Фільм↑劇場版 花咲くいろは HOME SWEET HOME|Hanasaku Iroha the Movie: Home Sweet Home|Hanasaku Iroha: Home Sweet Home
Як квітнуть квіти. Фільм↑劇場版 花咲くいろは HOME SWEET HOME|Hanasaku Iroha the Movie: Home Sweet Home|Hanasaku Iroha: Home Sweet Home
Як не треба викликати Лорда Демонів↑異世界魔王と召喚少女の奴隷魔術|How Not to Summon a Demon Lord|The Otherworldly Demon King and the Summoner Girls' Slave Magic
Як не треба викликати Лорда Демонів↑異世界魔王と召喚少女の奴隷魔術|How Not to Summon a Demon Lord|The Otherworldly Demon King and the Summoner Girls' Slave Magic
Як не треба викликати Лорда Демонів Омега↑異世界魔王と召喚少女の奴隷魔術Ω|How Not to Summon a Demon Lord Ω|How Not to Summon a Demon Lord 2nd Season|Isekai Maou to Shoukan Shoujo no Dorei Majutsu 2nd Season|The Otherworldly Demon King and the Summoner Girls' Slave Magic 2nd Season|Isekai Maou to Shoukan Shoujo no Dorei Majutsu Omega
Як не треба викликати Лорда Демонів Омега↑異世界魔王と召喚少女の奴隷魔術Ω|How Not to Summon a Demon Lord Ω|How Not to Summon a Demon Lord 2nd Season, Isekai Maou to Shoukan Shoujo no Dorei Majutsu 2nd Season, The Otherworldly Demon King and the Summoner Girls' Slave Magic 2nd Season, Isekai Maou to Shoukan Shoujo no Dorei Majutsu Omega
Як подбати про мумію↑ミイラの飼い方|How to Keep a Mummy|How to keep a mummy
Як ти поживаєш?↑君たちはどう生きるか|The Boy and the Heron|How Do You Live?
Якудза-няньки для лідерової дочки↑組長娘と世話係|The Yakuza's Guide to Babysitting
Якщо ти чарівник, їж місо!↑魔法使いなら味噌を喰え！|Mahoutsukai Nara Miso wo Kue!|Mahoutsukai nara Miso wo Kue!|Eat miso if you are sorcerer!|If You're a Wizard|Eat Miso!
Якщо ти чарівник, їж місо!↑魔法使いなら味噌を喰え！|Mahoutsukai Nara Miso wo Kue!|Mahoutsukai nara Miso wo Kue!, Eat miso if you are sorcerer!, If You're a Wizard, Eat Miso!
Якщо чесно, то я...↑実は私は|Actually, I am|Jitsuwata, The Truth Is I Am..., I am
Ямада та 7 відьом↑山田くんと7人の魔女|Yamada-kun and the Seven Witches|Yamada-kun to Nananin no Majo, Yamada-kun and the 7 Witches, Yamajo
Янгол віддається танцю з демоном↑愚かな天使は悪魔と踊る|The Foolish Angel Dances with the Devil|The Foolish Angel Dances with Demons, Kanaten
Янгол по сусідству мене розбещує↑お隣の天使様にいつの間にか駄目人間にされていた件|The Angel Next Door Spoils Me Rotten
Янголи пекла↑ヘルズ, (ヘルズエンジェルス)|Hells|Hells Angels|Hell's Angels
Янголи смерті↑殺戮の天使|Angels of Death|Angel of Massacre, Angel of Slaughter
Янгольські ритми!↑Angel Beats!（エンジェルビーツ!）|Angel Beats!
Янголятко, що прилетіло до мене!↑私に天使が舞い降りた！|Watashi ni Tenshi ga Maiorita! Special
Яскравий блиск Кірарі↑キラキラきらり☆|Kirakira Kirari
Яскраві: Душа самурая↑ブライト: サムライソウル|Bright: Samurai Soul
Яскраві: Душа самурая↑ブライト: サムライソウル|Bright: Samurai Soul
Ясуке↑YASUKE －ヤスケ－|Yasuke
хххГолік: Клітка↑xxxHOLiC 籠|xxxHOLiC Rou|xxxHOLiC Rou: Adayume
хххГолік: Сон літньої ночі↑劇場版　×××HOLiC　真夏ノ夜ノ夢|xxxHOLiC The Movie: A Midsummer Night's Dream|Gekijouban Horikku - Manatsu no Yoru no Yume|X-zobanHOLIC: Manatsu no Yo no Yume|xxxHolic - The Movie - A Midsummer's Night Dream
Ґабріель кидає школу↑ガヴリールドロップアウト|Gabriel DropOut
Ґабріель кидає школу↑ガヴリールドロップアウト|Gabriel DropOut
Ґалілей Донна↑ガリレイドンナ|Galilei Donna: Storia di tre sorelle a caccia di un mistero|Galilei Donna: the story of three sisters in the search of a mystery
Ґамба↑GAMBA ガンバと仲間たち|Air Bound|Gamba: Gamba and Companions
Ґангрейв↑ガングレイヴ|Gungrave
Ґанц↑ガンツ|Gantz|GANTZ
Ґанц:О↑GANTZ:O|Gantz:O|Gantz Movie
Ґанц:О|Ґанц: О↑GANTZ:O|Gantz:O|Gantz Movie
Ґанц:О↑GANTZ:O|Gantz:O|Gantz Movie
Ґанґста|Гангстери|Ґанґста / Гангстери↑GANGSTA. ギャングスタ|Gangsta
Ґарґантія на зеленій планеті↑翠星のガルガンティア|Gargantia on the Verdurous Planet|Suisei no Galgantia
Ґасаракі↑ガサラキ|Gasaraki
Ґеймери!↑ゲーマーズ！|Gamers!
Ґенешафт↑ジーンシャフト|Geneshaft
Ґлейпнір↑グレイプニル|Gleipnir
Ґодзіла. Точка сингулярності↑ゴジラ S.P ＜シンギュラポイント＞|Godzilla Singular Point
Ґодзіла: планета монстрів↑GODZILLA -怪獣惑星-|Godzilla: Planet of the Monsters
Ґокусен↑ごくせん|The Gokusen
Ґотика↑GOSICK -ゴシック-|Gosick
Ґранбелм↑グランベルム|Granbelm
Ґрімґар із ілюзій та попелу↑灰と幻想のグリムガル|Grimgar: Ashes and Illusions|Grimgal of Ashes and Fantasies|Hai to Gensou no Grimgal
Ґуррен Лаґанн↑天元突破グレンラガン|Gurren Lagann|Tengen Toppa Gurren-Lagann|Making Break-Through Gurren Lagann|Heavenly Breakthrough Gurren Lagann|TTGL|Gurren Laggan
Ґьорлз Бенд Край↑ガールズバンドクライ|Girls Band Cry
Ґівен↑ギヴン|Given
Ґівен. Фільм↑映画 ギヴン|Given Movie 1|Eiga Given
Ґівен. Фільм↑映画 ギヴン|Given Movie 1|Eiga Given
Ґівен: З іншого боку↑ギヴン うらがわの存在|given - on the other hand|Given OVA, Given OAD
Ґінтама|Ґінтама / Гінтама↑銀魂|Gintama|Gin Tama|Silver Soul|Yorinuki Gintama-san
"""
