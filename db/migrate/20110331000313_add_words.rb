class AddWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string    :word

      t.timestamps
    end

    create_table :user_words do |t|
      t.integer   :user_id
      t.integer   :word_id
      t.string    :custom_word
      t.boolean   :good, :default => true
      t.string    :ip

      t.timestamps
    end

    add_index :user_words, :user_id
    add_index :user_words, :word_id

    add_column :users, :ip, :string

    [
      "active",
      "adorable",
      "adrenaline junky",
      "adventurous",
      "affable",
      "affectionate",
      "aggressive",
      "ahead-of-the-curve",
      "aloof",
      "ambitious",
      "ambivalent",
      "amiable",
      "anal",
      "angelic",
      "angry",
      "animated",
      "annoying",
      "anxious",
      "argumentative",
      "arrogant",
      "artistic",
      "asshole",
      "athletic",
      "attentive",
      "babyish",
      "bad-smelling",
      "badass",
      "bastard",
      "belligerent",
      "benevolent",
      "big",
      "bigoted",
      "bitchy",
      "bitter",
      "bland",
      "blase",
      "boisterous",
      "bold",
      "boorish",
      "boring",
      "bossy",
      "brash",
      "brave",
      "brilliant",
      "brooding",
      "busy",
      "callous",
      "candid",
      "capable",
      "capitalistic",
      "careful",
      "caring",
      "casual",
      "cautious",
      "cavalier",
      "charismatic",
      "charitable",
      "charming",
      "cheap",
      "cheerful",
      "cheesy",
      "childish",
      "chill",
      "chivalrous",
      "classic",
      "clever",
      "clumsy",
      "coarse",
      "cocky",
      "cold",
      "cold-hearted",
      "competitive",
      "complacent",
      "complicated",
      "conceited",
      "concerned",
      "confident",
      "congenial",
      "conniving",
      "conscientious",
      "controlling",
      "conversationalist",
      "cool",
      "cooperative",
      "coordinated",
      "courageous",
      "crabby",
      "crafty",
      "crass",
      "crazy",
      "creative",
      "critical",
      "cross",
      "cruel",
      "crunchy",
      "cuddly",
      "cultured",
      "curious",
      "curt",
      "cute",
      "cynical",
      "dangerous",
      "daring",
      "dashing",
      "dastardly",
      "deceptive",
      "decisive",
      "deep",
      "delicate",
      "dependable",
      "depressed",
      "determined",
      "devoted",
      "dickish",
      "diligent",
      "disciplined",
      "discreet",
      "dishonest",
      "disrespectful",
      "distant",
      "distracted",
      "domineering",
      "doubtful",
      "drama",
      "drunkard",
      "dutiful",
      "eager",
      "earnest",
      "easy-going",
      "effervescent",
      "efficient",
      "ego",
      "elegant",
      "eloquent",
      "embarrassing",
      "emotional",
      "encouraging",
      "endearing",
      "energetic",
      "enthusiastic",
      "erratic",
      "evil",
      "exacting",
      "expert",
      "extroverted",
      "exuberant",
      "fair",
      "fanciful",
      "fancy",
      "fast",
      "fastidious",
      "fat",
      "fearful",
      "fearless",
      "feminine",
      "fidgety",
      "fierce",
      "finicky",
      "fit",
      "flippant",
      "flirty",
      "follower",
      "foolish",
      "fortunate",
      "frank",
      "freaky",
      "fresh",
      "friendly",
      "frugal",
      "frustrated",
      "full-of-energy",
      "funny",
      "fun",
      "generous",
      "genius",
      "giddy",
      "glamorous",
      "gloomy",
      "good-smelling",
      "graceful",
      "grateful",
      "gregarious",
      "groovy",
      "grumpy",
      "guarded",
      "gullible",
      "handsome",
      "handy",
      "hairy",
      "happy",
      "hard-working",
      "hardy",
      "harsh",
      "heartfelt",
      "helpful",
      "hick",
      "hillbilly",
      "hip",
      "holds-a-grudge",
      "honest",
      "hopeless",
      "hospitable",
      "hostile",
      "hot",
      "humble",
      "hyper",
      "immaculate",
      "immature",
      "impartial",
      "impolite",
      "important",
      "impossible",
      "impractical",
      "impulsive",
      "in-shape",
      "inactive",
      "indecisive",
      "independent",
      "indifferent",
      "indulgent",
      "industrious",
      "infuriating",
      "innocent",
      "insane",
      "insensitive",
      "insincere",
      "insipid",
      "insistant",
      "insolent",
      "intense",
      "interested",
      "interesting",
      "intrepid",
      "introverted",
      "inventive",
      "involved",
      "irreverent",
      "irresistible",
      "jacked",
      "jealous",
      "joker",
      "judgemental",
      "keen",
      "kooky",      
      "lackadaisical",
      "laid-back",
      "lazy",
      "leader",
      "lively",
      "logical",
      "lonely",
      "loose",
      "loquacious",
      "loud",
      "lovable",
      "loving",
      "loyal",
      "lucky",
      "lying",
      "manly",
      "mature",
      "mean",
      "meek",
      "mellow",
      "messy",
      "meticulous",
      "mischievious",
      "miserly",
      "moral",
      "motherly",
      "motivated",
      "musical",
      "mysterious",
      "narcissistic",
      "neat",
      "needy",
      "negative",
      "negligent",
      "nervous",
      "noisy",
      "obedient",
      "obliging",
      "obnoxious",
      "on drugs",
      "open",
      "open-minded",
      "optimistic",
      "orderly",
      "original",
      "out-going",
      "out-of-control",
      "out-of-shape",
      "out-there",
      "outdoorsy",
      "party animal",
      "patient",
      "perfectionist",
      "perseverant",
      "pessimistic",
      "petite",
      "petty",
      "petulant",
      "phat",
      "philosophical",
      "playful",
      "polished",
      "polite",
      "poor",
      "popular",
      "positive",
      "practical",
      "precise",
      "preppy",
      "presumptive",
      "pretentious",
      "prissy",
      "psycho",
      "punctual",
      "quick",
      "quiet",
      "racist",
      "radical",
      "rebellious",
      "relaxed",
      "religious",
      "renegade",
      "resourceful",
      "rich",
      "ridiculous",
      "ripped",
      "rough",
      "rude",
      "sane",
      "sarcastic",
      "scared",
      "scattered",
      "scrappy",
      "seductive",
      "selfish",
      "self-aware",
      "self-centered",
      "self-conscious",
      "self-deprecating",
      "sensitive",
      "serious",
      "sexy",
      "shallow",
      "short",
      "silly",
      "simple",
      "sincere",
      "skeptical",
      "skillful",
      "skinny",
      "skittish",
      "sloppy",
      "slovenly",
      "slow",
      "sluggish",
      "small",
      "smart",
      "sneaky",
      "snobby",
      "sour",
      "southern",
      "spiritual",
      "spiteful",
      "spontaneous",
      "sporty",
      "steely",
      "stiff",
      "stingy",
      "stoic",
      "stressed",
      "strong",
      "stubborn",
      "studly",
      "stupid",
      "sultry",
      "superficial",
      "suspicious",
      "svelt",
      "sweet",
      "sympathetic",
      "systematic",
      "tacky",
      "talented",
      "talkative",
      "tall",
      "tender",
      "tense",
      "thrifty",
      "tomboy",
      "tough",
      "travelled",
      "trusting",
      "trustworthy",
      "ugly",
      "unambitious",
      "unappreciative",
      "uncaring",
      "unfriendly",
      "ungrateful",
      "vain",
      "valiant",
      "vibrant",
      "visionary",
      "wasteful",
      "weak",
      "wealthy",
      "welcoming",
      "well-behaved",
      "wild",
      "wimpy",
      "wise",
      "witty",
      "workaholic",
      "worldly",
      "yuppy"
    ].each do |word|
      Word.create(:word => word)
    end

  end

  def self.down
    drop_table :words
    drop_table :user_words
    remove_column :users, :ip
  end
end
