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
    logo_url: "/assets/images/teams/clev.png",
    wins: 33,
    losses: 5
  },
  {
    name: "Boston Celtics",
    city: "Boston",
    conference: "East",
    rank: 2,
    logo_url: "/assets/images/teams/celtics.png",
    wins: 28,
    losses: 11
  },
  {
    name: "New York Knicks",
    city: "New York",
    conference: "East",
    rank: 3,
    logo_url: "/assets/images/teams/knicks.png",
    wins: 26,
    losses: 15
  },
  {
    name: "Orlando Magic",
    city: "Orlando",
    conference: "East",
    rank: 4,
    logo_url: "/assets/images/teams/orlando.png",
    wins: 23,
    losses: 18
  },
  {
    name: "Indiana Pacers",
    city: "Indiana",
    conference: "East",
    rank: 5,
    logo_url: "/assets/images/teams/pacers.png",
    wins: 22,
    losses: 18
  },
  {
    name: "Milwaukee Bucks",
    city: "Milwaukee",
    conference: "East",
    rank: 6,
    logo_url: "/assets/images/teams/bucks.png",
    wins: 20,
    losses: 17
  },
  {
    name: "Miami Heat",
    city: "Miami",
    conference: "East",
    rank: 7,
    logo_url: "/assets/images/teams/heats.png",
    wins: 20,
    losses: 18
  },
  {
    name: "Detroit Pistons",
    city: "Detroit",
    conference: "East",
    rank: 8,
    logo_url: "/assets/images/teams/detroit.png",
    wins: 21,
    losses: 19
  },
  {
    name: "Atlanta Hawks",
    city: "Atlanta",
    conference: "East",
    rank: 9,
    logo_url: "/assets/images/teams/atlanta.png",
    wins: 19,
    losses: 19
  },
  {
    name: "Chicago Bulls",
    city: "Chicago",
    conference: "East",
    rank: 10,
    logo_url: "/assets/images/teams/bulls.png",
    wins: 18,
    losses: 21
  },
  {
    name: "Philadelphia 76ers",
    city: "Philadelphia",
    conference: "East",
    rank: 11,
    logo_url: "/assets/images/teams/phila.png",
    wins: 15,
    losses: 22
  },
  {
    name: "Brooklyn Nets",
    city: "Brooklyn",
    conference: "East",
    rank: 12,
    logo_url: "/assets/images/teams/brooklyn.png",
    wins: 13,
    losses: 26
  },
  {
    name: "Toronto Raptors",
    city: "Toronto",
    conference: "East",
    rank: 13,
    logo_url: "/assets/images/teams/toronto.png",
    wins: 9,
    losses: 31
  },
  {
    name: "Charlotte Hornets",
    city: "Charlotte",
    conference: "East",
    rank: 14,
    logo_url: "/assets/images/teams/hornets.png",
    wins: 8,
    losses: 28
  },
  {
    name: "Washington Wizards",
    city: "Washington",
    conference: "East",
    rank: 15,
    logo_url: "/assets/images/teams/Wizzard.png",
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
    logo_url: "/assets/images/teams/thunder.png",
    wins: 32,
    losses: 6
  },
  {
    name: "Houston Rockets",
    city: "Houston",
    conference: "West",
    rank: 2,
    logo_url: "/assets/images/teams/rockets.png",
    wins: 26,
    losses: 12
  },
  {
    name: "Memphis Grizzlies",
    city: "Memphis",
    conference: "West",
    rank: 3,
    logo_url: "/assets/images/teams/memphis.png",
    wins: 25,
    losses: 15
  },
  {
    name: "Denver Nuggets",
    city: "Denver",
    conference: "West",
    rank: 4,
    logo_url: "/assets/images/teams/denver.png",
    wins: 23,
    losses: 15
  },
  {
    name: "Dallas Mavericks",
    city: "Dallas",
    conference: "West",
    rank: 5,
    logo_url: "/assets/images/teams/dallas.png",
    wins: 22,
    losses: 17
  },
  {
    name: "Los Angeles Clippers",
    city: "Los Angeles",
    conference: "West",
    rank: 6,
    logo_url: "/assets/images/teams/clippers.png",
    wins: 21,
    losses: 17
  },
  {
    name: "Los Angeles Lakers",
    city: "Los Angeles",
    conference: "West",
    rank: 7,
    logo_url: "/assets/images/teams/Lakers.png",
    wins: 20,
    losses: 17
  },
  {
    name: "Minnesota Timberwolves",
    city: "Minnesota",
    conference: "West",
    rank: 8,
    logo_url: "/assets/images/teams/wolves.png",
    wins: 21,
    losses: 18
  },
  {
    name: "Sacramento Kings",
    city: "Sacramento",
    conference: "West",
    rank: 9,
    logo_url: "/assets/images/teams/sacramento.png",
    wins: 20,
    losses: 19
  },
  {
    name: "Phoenix Suns",
    city: "Phoenix",
    conference: "West",
    rank: 10,
    logo_url: "/assets/images/teams/Suns.png",
    wins: 19,
    losses: 19
  },
  {
    name: "San Antonio Spurs",
    city: "San Antonio",
    conference: "West",
    rank: 11,
    logo_url: "/assets/images/teams/spurs.png",
    wins: 19,
    losses: 19
  },
  {
    name: "Golden State Warriors",
    city: "Golden State",
    conference: "West",
    rank: 12,
    logo_url: "/assets/images/teams/warriors.png",
    wins: 19,
    losses: 20
  },
  {
    name: "Portland Trail Blazers",
    city: "Portland",
    conference: "West",
    rank: 13,
    logo_url: "/assets/images/teams/blazzers.png",
    wins: 13,
    losses: 25
  },
  {
    name: "Utah Jazz",
    city: "Utah",
    conference: "West",
    rank: 14,
    logo_url: "/assets/images/teams/jazz.png",
    wins: 10,
    losses: 28
  },
  {
    name: "New Orleans Pelicans",
    city: "New Orleans",
    conference: "West",
    rank: 15,
    logo_url: "/assets/images/teams/pelicans.png",
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
players = [
  {
    name: "Jayson Tatum",
    profile: "Forward",
    image: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png",
    team: Team.find_by(name: "Boston Celtics")
  },
  {
    name: "Giannis Antetokounmpo",
    profile: "Forward",
    image: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png",
    team: Team.find_by(name: "Milwaukee Bucks")
  },
  {
    name: "Nikola Jokic",
    profile: "Center",
    image: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png",
    team: Team.find_by(name: "Denver Nuggets")
  },
  {
    name: "Devin Booker",
    profile: "Guard",
    image: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png",
    team: Team.find_by(name: "Phoenix Suns")
  },
  {
    name: "LeBron James",
    profile: "Forward",
    image: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png",
    team: Team.find_by(name: "Los Angeles Lakers")
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
puts "Creating games..."
games = [
  {
    team_1: Team.find_by(name: "Boston Celtics"),
    team_2: Team.find_by(name: "Milwaukee Bucks"),
    date: DateTime.new(2025, 1, 15, 19, 30),
    team_1_score: 112,
    team_2_score: 108
  },
  {
    team_1: Team.find_by(name: "Denver Nuggets"),
    team_2: Team.find_by(name: "Phoenix Suns"),
    date: DateTime.new(2025, 1, 16, 20, 00),
    team_1_score: 108,
    team_2_score: 102
  },
  {
    team_1: Team.find_by(name: "Los Angeles Lakers"),
    team_2: Team.find_by(name: "Boston Celtics"),
    date: DateTime.new(2025, 1, 17, 18, 30),
    team_1_score: 115,
    team_2_score: 120
  },
  {
    team_1: Team.find_by(name: "Milwaukee Bucks"),
    team_2: Team.find_by(name: "Phoenix Suns"),
    date: DateTime.new(2025, 1, 18, 19, 00),
    team_1_score: 105,
    team_2_score: 98
  },
  {
    team_1: Team.find_by(name: "Denver Nuggets"),
    team_2: Team.find_by(name: "Los Angeles Lakers"),
    date: DateTime.new(2025, 1, 19, 20, 30),
    team_1_score: 118,
    team_2_score: 112
  }
]

created_games = games.map do |game|
  Game.create!(game)
end

# Création des favoris
puts "Creating favorites..."
User.all.each do |user|
  # Ajout de 2 équipes favorites aléatoires pour chaque utilisateur
  teams_sample = Team.all.sample(2)
  teams_sample.each do |team|
    FavoriteTeam.create!(
      user: user,
      team: team
    )
  end

  # Ajout de 2 joueurs favoris aléatoires pour chaque utilisateur
  players_sample = Player.all.sample(2)
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
