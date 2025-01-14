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
teams = [
  {
    name: "Boston Celtics",
    city: "Boston",
    conference: "East",
    rank: 1,
    logo_url: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"
  },
  {
    name: "Milwaukee Bucks",
    city: "Milwaukee",
    conference: "East",
    rank: 2,
    logo_url: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"
  },
  {
    name: "Denver Nuggets",
    city: "Denver",
    conference: "West",
    rank: 1,
    logo_url: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"
  },
  {
    name: "Phoenix Suns",
    city: "Phoenix",
    conference: "West",
    rank: 4,
    logo_url: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"
  },
  {
    name: "Los Angeles Lakers",
    city: "Los Angeles",
    conference: "West",
    rank: 7,
    logo_url: "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"
  }
]


created_teams = teams.map do |team|
  Team.create!(team)
end

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
