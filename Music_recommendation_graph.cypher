// VERSÃO COMPLETA E CORRETA COM MERGE
 MATCH (n) DETACH DELETE n;
// Criar Users
MERGE (u1:User {id: "user1"})
SET u1.name = "Ana Silva", u1.age = 25, u1.gender = "F", u1.email = "ana@email.com"

MERGE (u2:User {id: "user2"})
SET u2.name = "Bruno Costa", u2.age = 30, u2.gender = "M", u2.email = "bruno@email.com"

// Criar Musicas
MERGE (m1:Music {id: "music1"})
SET m1.title = "Anti-Hero", m1.duration = 200, m1.release_year = 2022, m1.plays = 1500000

MERGE (m2:Music {id: "music2"})
SET m2.title = "Blinding Lights", m2.duration = 203, m2.release_year = 2019, m2.plays = 2800000

// Criar Artistas
MERGE (a1:Artist {id: "artist1"})
SET a1.name = "Taylor Swift", a1.age = 33, a1.gender = "F", a1.genre = "Pop"

MERGE (a2:Artist {id: "artist2"})
SET a2.name = "The Weeknd", a2.age = 33, a2.gender = "M", a2.genre = "R&B"

// Criar Gêneros
MERGE (g1:Genre {id: "genre1"})
SET g1.name = "Pop", g1.year_created = 1950, g1.description = "Popular Music"

MERGE (g2:Genre {id: "genre2"})
SET g2.name = "R&B", g2.year_created = 1940, g2.description = "Rhythm and Blues"

// Criar relacionamentos LISTEN
MERGE (u1:User {id: "user1"})
MERGE (m1:Music {id: "music1"})
MERGE (u1)-[l1:LISTEN]->(m1)
SET l1.like = true, l1.timestamp = datetime('2023-10-01T08:30:00'), l1.plays = 15
MERGE (u2:User {id: "user2"})
MERGE (m1:Music {id: "music1"})
MERGE (u2)-[l2:LISTEN]->(m1)
SET l2.like = true, l2.timestamp = datetime('2025-10-31T11:30:00'), l2.plays = 35

// Criar relacionamentos SINGS
MERGE (a1:Artist {id: "artist1"})
MERGE (m1:Music {id: "music1"})
MERGE (a1)-[s1:SINGS]->(m1)
SET s1.writing_credits = true, s1.producer = "Taylor Swift"
MERGE (a2:Artist {id: "artist2"})
MERGE (m2:Music {id: "music2"})
MERGE (a2)-[s2:SINGS]->(m2)
SET s2.writing_credits = true, s2.producer = "Bill Nox"

// Criar relacionamentos FOLLOW
MERGE (u1:User {id: "user1"})
MERGE (a1:Artist {id: "artist1"})
MERGE (u1)-[f1:FOLLOW]->(a1)
SET f1.since = date('2023-01-15')
MERGE (u2:User {id: "user2"})
MERGE (a2:Artist {id: "artist2"})
MERGE (u2)-[f2:FOLLOW]->(a2
SET f2.since = date('2023-11-11')

// Criar relacionamentos BELONGS_TO
MERGE (m1:Music {id: "music1"})
MERGE (g1:Genre {id: "genre1"})
MERGE (m1)-[b1:BELONGS_TO]->(g1)
SET b1.primary = true;
MERGE (m2:Music {id: "music2"})
MERGE (g2:Genre {id: "genre2"})
MERGE (m2)-[b2:BELONGS_TO]->(g2)
SET b2.primary = true;