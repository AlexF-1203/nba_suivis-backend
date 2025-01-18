# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb




# Nettoyage de la base de données
puts "Cleaning database..."
# D'abord les tables avec les clés étrangères
FavoritePlayer.destroy_all
FavoriteTeam.destroy_all
Game.destroy_all
Player.destroy_all
# Puis les tables principales
Team.destroy_all
User.destroy_all
# Création des équipes
puts "Creating teams..."
eastern_teams = [
  {
    name: "Cleveland Cavaliers",
    city: "Cleveland",
    conference: "East",
    rank: 1,
    logo_url: "/assets/teams/clev.png",
    wins: 33,
    losses: 5
  },
  {
    name: "Boston Celtics",
    city: "Boston",
    conference: "East",
    rank: 2,
    logo_url: "/assets/teams/celtics.png",
    wins: 28,
    losses: 11
  },
  {
    name: "New York Knicks",
    city: "New York",
    conference: "East",
    rank: 3,
    logo_url: "/assets/teams/knicks.png",
    wins: 26,
    losses: 15
  },
  {
    name: "Orlando Magic",
    city: "Orlando",
    conference: "East",
    rank: 4,
    logo_url: "/assets/teams/orlando.png",
    wins: 23,
    losses: 18
  },
  {
    name: "Indiana Pacers",
    city: "Indiana",
    conference: "East",
    rank: 5,
    logo_url: "/assets/teams/pacers.png",
    wins: 22,
    losses: 18
  },
  {
    name: "Milwaukee Bucks",
    city: "Milwaukee",
    conference: "East",
    rank: 6,
    logo_url: "/assets/teams/bucks.png",
    wins: 20,
    losses: 17
  },
  {
    name: "Miami Heat",
    city: "Miami",
    conference: "East",
    rank: 7,
    logo_url: "/assets/teams/heats.png",
    wins: 20,
    losses: 18
  },
  {
    name: "Detroit Pistons",
    city: "Detroit",
    conference: "East",
    rank: 8,
    logo_url: "/assets/teams/detroit.png",
    wins: 21,
    losses: 19
  },
  {
    name: "Atlanta Hawks",
    city: "Atlanta",
    conference: "East",
    rank: 9,
    logo_url: "/assets/teams/atlanta.png",
    wins: 19,
    losses: 19
  },
  {
    name: "Chicago Bulls",
    city: "Chicago",
    conference: "East",
    rank: 10,
    logo_url: "/assets/teams/bulls.png",
    wins: 18,
    losses: 21
  },
  {
    name: "Philadelphia 76ers",
    city: "Philadelphia",
    conference: "East",
    rank: 11,
    logo_url: "/assets/teams/phila.png",
    wins: 15,
    losses: 22
  },
  {
    name: "Brooklyn Nets",
    city: "Brooklyn",
    conference: "East",
    rank: 12,
    logo_url: "/assets/teams/brooklyn.png",
    wins: 13,
    losses: 26
  },
  {
    name: "Toronto Raptors",
    city: "Toronto",
    conference: "East",
    rank: 13,
    logo_url: "/assets/teams/toronto.png",
    wins: 9,
    losses: 31
  },
  {
    name: "Charlotte Hornets",
    city: "Charlotte",
    conference: "East",
    rank: 14,
    logo_url: "/assets/teams/hornets.png",
    wins: 8,
    losses: 28
  },
  {
    name: "Washington Wizards",
    city: "Washington",
    conference: "East",
    rank: 15,
    logo_url: "/assets/teams/Wizzard.png",
    wins: 6,
    losses: 32
  }
]

# Western Conference Teams
western_teams = [
  {
    name: "Oklahoma City Thunder",
    city: "Oklahoma City",
    conference: "West",
    rank: 1,
    logo_url: "/assets/teams/thunder.png",
    wins: 32,
    losses: 6
  },
  {
    name: "Houston Rockets",
    city: "Houston",
    conference: "West",
    rank: 2,
    logo_url: "/assets/teams/rockets.png",
    wins: 26,
    losses: 12
  },
  {
    name: "Memphis Grizzlies",
    city: "Memphis",
    conference: "West",
    rank: 3,
    logo_url: "/assets/teams/memphis.png",
    wins: 25,
    losses: 15
  },
  {
    name: "Denver Nuggets",
    city: "Denver",
    conference: "West",
    rank: 4,
    logo_url: "/assets/teams/denver.png",
    wins: 23,
    losses: 15
  },
  {
    name: "Dallas Mavericks",
    city: "Dallas",
    conference: "West",
    rank: 5,
    logo_url: "/assets/teams/dallas.png",
    wins: 22,
    losses: 17
  },
  {
    name: "Los Angeles Clippers",
    city: "Los Angeles",
    conference: "West",
    rank: 6,
    logo_url: "/assets/teams/clippers.png",
    wins: 21,
    losses: 17
  },
  {
    name: "Los Angeles Lakers",
    city: "Los Angeles",
    conference: "West",
    rank: 7,
    logo_url: "/assets/teams/Lakers.png",
    wins: 20,
    losses: 17
  },
  {
    name: "Minnesota Timberwolves",
    city: "Minnesota",
    conference: "West",
    rank: 8,
    logo_url: "/assets/teams/wolves.png",
    wins: 21,
    losses: 18
  },
  {
    name: "Sacramento Kings",
    city: "Sacramento",
    conference: "West",
    rank: 9,
    logo_url: "/assets/teams/sacramento.png",
    wins: 20,
    losses: 19
  },
  {
    name: "Phoenix Suns",
    city: "Phoenix",
    conference: "West",
    rank: 10,
    logo_url: "/assets/teams/Suns.png",
    wins: 19,
    losses: 19
  },
  {
    name: "San Antonio Spurs",
    city: "San Antonio",
    conference: "West",
    rank: 11,
    logo_url: "/assets/teams/spurs.png",
    wins: 19,
    losses: 19
  },
  {
    name: "Golden State Warriors",
    city: "Golden State",
    conference: "West",
    rank: 12,
    logo_url: "/assets/teams/warriors.png",
    wins: 19,
    losses: 20
  },
  {
    name: "Portland Trail Blazers",
    city: "Portland",
    conference: "West",
    rank: 13,
    logo_url: "/assets/teams/blazzers.png",
    wins: 13,
    losses: 25
  },
  {
    name: "Utah Jazz",
    city: "Utah",
    conference: "West",
    rank: 14,
    logo_url: "/assets/teams/jazz.png",
    wins: 10,
    losses: 28
  },
  {
    name: "New Orleans Pelicans",
    city: "New Orleans",
    conference: "West",
    rank: 15,
    logo_url: "/assets/teams/pelicans.png",
    wins: 8,
    losses: 32
  }
]


all_teams = eastern_teams + western_teams
created_teams = all_teams.map do |team_data|
  Team.create!(
    name: team_data[:name],
    city: team_data[:city],
    conference: team_data[:conference],
    rank: team_data[:rank],
    logo_url: team_data[:logo_url],
    wins: team_data[:wins],
    losses: team_data[:losses]
  )
end

puts "Created #{Team.count} teams"

# Création des joueurs
puts "Creating players..."
# Création des joueurs
puts "Creating players..."
players = [
  # Eastern Conference
  # Cleveland Cavaliers
  {
    name: "Donovan Mitchell",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628378.png",
    team: Team.find_by(name: "Cleveland Cavaliers")
  },
  {
    name: "Darius Garland",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629636.png",
    team: Team.find_by(name: "Cleveland Cavaliers")
  },
  {
    name: "Jarrett Allen",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628386.png",
    team: Team.find_by(name: "Cleveland Cavaliers")
  },

  # Boston Celtics
  {
    name: "Jayson Tatum",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628369.png",
    team: Team.find_by(name: "Boston Celtics")
  },
  {
    name: "Jaylen Brown",
    profile: "Guard-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627759.png",
    team: Team.find_by(name: "Boston Celtics")
  },
  {
    name: "Kristaps Porzingis",
    profile: "Center-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1626163.png",
    team: Team.find_by(name: "Boston Celtics")
  },

  # New York Knicks
  {
    name: "Jalen Brunson",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628973.png",
    team: Team.find_by(name: "New York Knicks")
  },
  {
    name: "OG Anunoby",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628384.png",
    team: Team.find_by(name: "New York Knicks")
  },
  {
    name: "Donte DiVincenzo",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628978.png",
    team: Team.find_by(name: "New York Knicks")
  },

  # Orlando Magic
  {
    name: "Paolo Banchero",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1631094.png",
    team: Team.find_by(name: "Orlando Magic")
  },
  {
    name: "Franz Wagner",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630532.png",
    team: Team.find_by(name: "Orlando Magic")
  },
  {
    name: "Jalen Suggs",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630591.png",
    team: Team.find_by(name: "Orlando Magic")
  },

  # Indiana Pacers
  {
    name: "Tyrese Haliburton",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630169.png",
    team: Team.find_by(name: "Indiana Pacers")
  },
  {
    name: "Pascal Siakam",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627783.png",
    team: Team.find_by(name: "Indiana Pacers")
  },
  {
    name: "Myles Turner",
    profile: "Center-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1626167.png",
    team: Team.find_by(name: "Indiana Pacers")
  },

  # Milwaukee Bucks
  {
    name: "Giannis Antetokounmpo",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203507.png",
    team: Team.find_by(name: "Milwaukee Bucks")
  },
  {
    name: "Damian Lillard",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203081.png",
    team: Team.find_by(name: "Milwaukee Bucks")
  },
  {
    name: "Brook Lopez",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/201572.png",
    team: Team.find_by(name: "Milwaukee Bucks")
  },

  # Miami Heat
  {
    name: "Jimmy Butler",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202710.png",
    team: Team.find_by(name: "Miami Heat")
  },
  {
    name: "Bam Adebayo",
    profile: "Center-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628389.png",
    team: Team.find_by(name: "Miami Heat")
  },
  {
    name: "Tyler Herro",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629639.png",
    team: Team.find_by(name: "Miami Heat")
  },

  # Detroit Pistons
  {
    name: "Cade Cunningham",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630595.png",
    team: Team.find_by(name: "Detroit Pistons")
  },
  {
    name: "Jalen Duren",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1631105.png",
    team: Team.find_by(name: "Detroit Pistons")
  },
  {
    name: "Simone Fontecchio",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630695.png",
    team: Team.find_by(name: "Detroit Pistons")
  },

  # Atlanta Hawks
  {
    name: "Trae Young",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629027.png",
    team: Team.find_by(name: "Atlanta Hawks")
  },
  {
    name: "Dejounte Murray",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627749.png",
    team: Team.find_by(name: "Atlanta Hawks")
  },
  {
    name: "Clint Capela",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203991.png",
    team: Team.find_by(name: "Atlanta Hawks")
  },

  # Chicago Bulls
  {
    name: "DeMar DeRozan",
    profile: "Forward-Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/201942.png",
    team: Team.find_by(name: "Chicago Bulls")
  },
  {
    name: "Coby White",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629632.png",
    team: Team.find_by(name: "Chicago Bulls")
  },
  {
    name: "Nikola Vucevic",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202696.png",
    team: Team.find_by(name: "Chicago Bulls")
  },

  # Philadelphia 76ers
  {
    name: "Joel Embiid",
    profile: "Center-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203954.png",
    team: Team.find_by(name: "Philadelphia 76ers")
  },
  {
    name: "Tyrese Maxey",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630178.png",
    team: Team.find_by(name: "Philadelphia 76ers")
  },
  {
    name: "Tobias Harris",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202699.png",
    team: Team.find_by(name: "Philadelphia 76ers")
  },

  # Brooklyn Nets
  {
    name: "Mikal Bridges",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628969.png",
    team: Team.find_by(name: "Brooklyn Nets")
  },
  {
    name: "Cameron Johnson",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629661.png",
    team: Team.find_by(name: "Brooklyn Nets")
  },
  {
    name: "Ben Simmons",
    profile: "Guard-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627732.png",
    team: Team.find_by(name: "Brooklyn Nets")
  },

  # Toronto Raptors
  {
    name: "Scottie Barnes",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630567.png",
    team: Team.find_by(name: "Toronto Raptors")
  },
  {
    name: "RJ Barrett",
    profile: "Forward-Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629628.png",
    team: Team.find_by(name: "Toronto Raptors")
  },
  {
    name: "Immanuel Quickley",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630193.png",
    team: Team.find_by(name: "Toronto Raptors")
  },

  # Charlotte Hornets
  {
    name: "LaMelo Ball",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630163.png",
    team: Team.find_by(name: "Charlotte Hornets")
  },
  {
    name: "Brandon Miller",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1641739.png",
    team: Team.find_by(name: "Charlotte Hornets")
  },
  {
    name: "Miles Bridges",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628970.png",
    team: Team.find_by(name: "Charlotte Hornets")
  },

  # Washington Wizards
  {
    name: "Kyle Kuzma",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628398.png",
    team: Team.find_by(name: "Washington Wizards")
  },
  {
    name: "Jordan Poole",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629673.png",
    team: Team.find_by(name: "Washington Wizards")
  },
  {
    name: "Tyus Jones",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1626145.png",
    team: Team.find_by(name: "Washington Wizards")
  },

  # Western Conference
  # Oklahoma City Thunder
  {
    name: "Shai Gilgeous-Alexander",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628983.png",
    team: Team.find_by(name: "Oklahoma City Thunder")
  },
  {
    name: "Jalen Williams",
    profile: "Forward-Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1631114.png",
    team: Team.find_by(name: "Oklahoma City Thunder")
  },
  {
    name: "Chet Holmgren",
    profile: "Center-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1631096.png",
    team: Team.find_by(name: "Oklahoma City Thunder")
  },

  # Houston Rockets
  {
    name: "Alperen Sengun",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630578.png",
    team: Team.find_by(name: "Houston Rockets")
  },
  {
    name: "Jalen Green",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630224.png",
    team: Team.find_by(name: "Houston Rockets")
  },
  {
    name: "Fred VanVleet",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627832.png",
    team: Team.find_by(name: "Houston Rockets")
  },

  # Memphis Grizzlies
  {
    name: "Ja Morant",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629630.png",
    team: Team.find_by(name: "Memphis Grizzlies")
  },
  {
    name: "Jaren Jackson Jr.",
    profile: "Forward-Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628991.png",
    team: Team.find_by(name: "Memphis Grizzlies")
  },
  {
    name: "Marcus Smart",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203935.png",
    team: Team.find_by(name: "Memphis Grizzlies")
  },

  # Denver Nuggets
  {
    name: "Nikola Jokic",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203999.png",
    team: Team.find_by(name: "Denver Nuggets")
  },
  {
    name: "Jamal Murray",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627750.png",
    team: Team.find_by(name: "Denver Nuggets")
  },
  {
    name: "Michael Porter Jr.",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629008.png",
    team: Team.find_by(name: "Denver Nuggets")
  },

  # Dallas Mavericks
  {
    name: "Luka Doncic",
    profile: "Guard-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629029.png",
    team: Team.find_by(name: "Dallas Mavericks")
  },
  {
    name: "Kyrie Irving",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202681.png",
    team: Team.find_by(name: "Dallas Mavericks")
  },
  {
    name: "Daniel Gafford",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629655.png",
    team: Team.find_by(name: "Dallas Mavericks")
  },

  # Los Angeles Clippers
  {
    name: "Kawhi Leonard",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202695.png",
    team: Team.find_by(name: "Los Angeles Clippers")
  },
  {
    name: "Paul George",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202331.png",
    team: Team.find_by(name: "Los Angeles Clippers")
  },
  {
    name: "James Harden",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/201935.png",
    team: Team.find_by(name: "Los Angeles Clippers")
  },

  # Los Angeles Lakers
  {
    name: "LeBron James",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/2544.png",
    team: Team.find_by(name: "Los Angeles Lakers")
  },
  {
    name: "Anthony Davis",
    profile: "Forward-Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203076.png",
    team: Team.find_by(name: "Los Angeles Lakers")
  },
  {
    name: "D'Angelo Russell",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1626156.png",
    team: Team.find_by(name: "Los Angeles Lakers")
  },

  # Minnesota Timberwolves
  {
    name: "Anthony Edwards",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630162.png",
    team: Team.find_by(name: "Minnesota Timberwolves")
  },
  {
    name: "Karl-Anthony Towns",
    profile: "Center-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1626157.png",
    team: Team.find_by(name: "Minnesota Timberwolves")
  },
  {
    name: "Rudy Gobert",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203497.png",
    team: Team.find_by(name: "Minnesota Timberwolves")
  },

  # Sacramento Kings
  {
    name: "De'Aaron Fox",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628368.png",
    team: Team.find_by(name: "Sacramento Kings")
  },
  {
    name: "Domantas Sabonis",
    profile: "Forward-Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627734.png",
    team: Team.find_by(name: "Sacramento Kings")
  },
  {
    name: "Malik Monk",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628370.png",
    team: Team.find_by(name: "Sacramento Kings")
  },

  # Phoenix Suns
  {
    name: "Devin Booker",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1626164.png",
    team: Team.find_by(name: "Phoenix Suns")
  },
  {
    name: "Kevin Durant",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/201142.png",
    team: Team.find_by(name: "Phoenix Suns")
  },
  {
    name: "Bradley Beal",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203078.png",
    team: Team.find_by(name: "Phoenix Suns")
  },

  # San Antonio Spurs
  {
    name: "Victor Wembanyama",
    profile: "Forward-Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1641705.png",
    team: Team.find_by(name: "San Antonio Spurs")
  },
  {
    name: "Devin Vassell",
    profile: "Guard-Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1630170.png",
    team: Team.find_by(name: "San Antonio Spurs")
  },
  {
    name: "Keldon Johnson",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629640.png",
    team: Team.find_by(name: "San Antonio Spurs")
  },

  # Golden State Warriors
  {
    name: "Stephen Curry",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/201939.png",
    team: Team.find_by(name: "Golden State Warriors")
  },
  {
    name: "Klay Thompson",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/202691.png",
    team: Team.find_by(name: "Golden State Warriors")
  },
  {
    name: "Draymond Green",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203110.png",
    team: Team.find_by(name: "Golden State Warriors")
  },

  # Portland Trail Blazers
  {
    name: "Anfernee Simons",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629014.png",
    team: Team.find_by(name: "Portland Trail Blazers")
  },
  {
    name: "Scoot Henderson",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1641704.png",
    team: Team.find_by(name: "Portland Trail Blazers")
  },
  {
    name: "Deandre Ayton",
    profile: "Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629028.png",
    team: Team.find_by(name: "Portland Trail Blazers")
  },

  # Utah Jazz
  {
    name: "Lauri Markkanen",
    profile: "Forward-Center",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628374.png",
    team: Team.find_by(name: "Utah Jazz")
  },
  {
    name: "Jordan Clarkson",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203903.png",
    team: Team.find_by(name: "Utah Jazz")
  },
  {
    name: "John Collins",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1628381.png",
    team: Team.find_by(name: "Utah Jazz")
  },

  # New Orleans Pelicans
  {
    name: "Zion Williamson",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1629627.png",
    team: Team.find_by(name: "New Orleans Pelicans")
  },
  {
    name: "Brandon Ingram",
    profile: "Forward",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/1627742.png",
    team: Team.find_by(name: "New Orleans Pelicans")
  },
  {
    name: "CJ McCollum",
    profile: "Guard",
    image: "https://cdn.nba.com/headshots/nba/latest/1040x760/203468.png",
    team: Team.find_by(name: "New Orleans Pelicans")
  }
]

created_players = players.map do |player|
  Player.create!(player)
end

# Création des utilisateurs
puts "Creating users..."
users = [
  { email: "admin@test.com", password: "password", username: "NBAFan1" },
  { email: "user2@example.com", password: "password123", username: "HoopsMaster" },
  { email: "user3@example.com", password: "password123", username: "BasketballLover" },
  { email: "user4@example.com", password: "password123", username: "CourtKing" },
  { email: "user5@example.com", password: "password123", username: "BballExpert" }
]

created_users = users.map do |user|
  User.create!(user)
end

# Création des matchs
# puts "Creating games..."
# games = [
#   {
#     team_1: Team.find_by(name: "Boston Celtics"),
#     team_2: Team.find_by(name: "Milwaukee Bucks"),
#     date: DateTime.new(2025, 1, 15, 19, 30),
#     team_1_score: 112,
#     team_2_score: 108
#   },
#   {
#     team_1: Team.find_by(name: "Denver Nuggets"),
#     team_2: Team.find_by(name: "Phoenix Suns"),
#     date: DateTime.new(2025, 1, 16, 20, 00),
#     team_1_score: 108,
#     team_2_score: 102
#   },
#   {
#     team_1: Team.find_by(name: "Los Angeles Lakers"),
#     team_2: Team.find_by(name: "Boston Celtics"),
#     date: DateTime.new(2025, 1, 17, 18, 30),
#     team_1_score: 115,
#     team_2_score: 120
#   },
#   {
#     team_1: Team.find_by(name: "Milwaukee Bucks"),
#     team_2: Team.find_by(name: "Phoenix Suns"),
#     date: DateTime.new(2025, 1, 18, 19, 00),
#     team_1_score: 105,
#     team_2_score: 98
#   },
#   {
#     team_1: Team.find_by(name: "Denver Nuggets"),
#     team_2: Team.find_by(name: "Los Angeles Lakers"),
#     date: DateTime.new(2025, 1, 19, 20, 30),
#     team_1_score: 118,
#     team_2_score: 112
#   }
# ]

# created_games = games.map do |game|
#   Game.create!(game)
# end

# Création des favoris
puts "Creating favorites..."
User.all.each do |user|
  # Ajout de 2 équipes favorites aléatoires pour chaque utilisateur
  teams_sample = Team.all.sample(3)
  teams_sample.each do |team|
    FavoriteTeam.create!(
      user: user,
      team: team
    )
  end

  # Ajout de 2 joueurs favoris aléatoires pour chaque utilisateur
  players_sample = Player.all.sample(5)
  players_sample.each do |player|
    FavoritePlayer.create!(
      user: user,
      player: player
    )
  end
end

puts "Seed completed! Created:"
puts "- #{Team.count} teams"
puts "- #{Player.count} players"
puts "- #{User.count} users"
puts "- #{Game.count} games"
puts "- #{FavoriteTeam.count} favorite teams"
puts "- #{FavoritePlayer.count} favorite players"
