// Recomenda músicas que usuários do mesmo gênero e faixa etária curtem
MATCH (target:User {id: "user1"})
MATCH (similar:User {gender: target.gender})
WHERE similar.id <> target.id AND abs(similar.age - target.age) <= 5
MATCH (similar)-[l:LISTEN {like: true}]->(recommended:Music)
WHERE NOT EXISTS ((target)-[:LISTEN]->(recommended))
RETURN recommended.title AS Musica,
       recommended.duration AS Duracao,
       COUNT(similar) AS Usuarios_Similares,
       AVG(l.plays) AS Media_Reproducoes
ORDER BY Usuarios_Similares DESC, Media_Reproducoes DESC
LIMIT 10;

// Recomenda músicas de artistas similares aos que o usuário segue
MATCH (u:User {id: "user1"})-[:FOLLOW]->(followed:Artist)
MATCH (followed)-[:SINGS]->(followedMusic:Music)
MATCH (similarArtist:Artist)-[:SINGS]->(recommended:Music)
WHERE similarArtist.genre = followed.genre 
  AND similarArtist.id <> followed.id
  AND NOT EXISTS ((u)-[:LISTEN]->(recommended))
RETURN recommended.title AS Musica,
       similarArtist.name AS Artista,
       similarArtist.genre AS Genero,
       COUNT(followed) AS Artistas_Similares
ORDER BY Artistas_Similares DESC
LIMIT 10;

// Recomenda músicas do mesmo gênero das que o usuário já curtiu
MATCH (u:User {id: "user1"})-[l:LISTEN {like: true}]->(liked:Music)
MATCH (liked)-[:BELONGS_TO]->(g:Genre)
MATCH (recommended:Music)-[:BELONGS_TO {primary: true}]->(g)
WHERE NOT EXISTS ((u)-[:LISTEN]->(recommended))
RETURN recommended.title AS Musica,
       g.name AS Genero,
       COUNT(liked) AS Musicas_Curtidas_Mesmo_Genero,
       recommended.plays AS Total_Reproducoes
ORDER BY Musicas_Curtidas_Mesmo_Genero DESC, Total_Reproducoes DESC
LIMIT 10;

// Recomenda baseado no padrão de reprodução (músicas com alta taxa de like)
MATCH (u:User {id: "user1"})-[l:LISTEN]->(m:Music)
WITH u, AVG(l.plays) AS avgPlays
MATCH (other:User)-[ol:LISTEN {like: true}]->(recommended:Music)
WHERE ol.plays >= avgPlays * 0.8
  AND NOT EXISTS ((u)-[:LISTEN]->(recommended))
RETURN recommended.title AS Musica,
       COUNT(other) AS Usuarios_Que_Curtiram,
       AVG(ol.plays) AS Media_Reproducoes,
       recommended.release_year AS Ano
ORDER BY Usuarios_Que_Curtiram DESC, Media_Reproducoes DESC
LIMIT 10;

// Recomenda artistas novos do mesmo gênero dos artistas seguidos
MATCH (u:User {id: "user1"})-[:FOLLOW]->(followed:Artist)
WITH u, COLLECT(DISTINCT followed.genre) AS followedGenres
UNWIND followedGenres AS genre
MATCH (newArtist:Artist)-[:SINGS]->(recommended:Music)
WHERE newArtist.genre = genre
  AND NOT EXISTS ((u)-[:FOLLOW]->(newArtist))
  AND NOT EXISTS ((u)-[:LISTEN]->(recommended))
RETURN recommended.title AS Musica,
       newArtist.name AS Artista,
       newArtist.genre AS Genero,
       newArtist.age AS Idade_Artista,
       recommended.release_year AS Ano_Lancamento
ORDER BY recommended.release_year DESC, recommended.plays DESC
LIMIT 10;

