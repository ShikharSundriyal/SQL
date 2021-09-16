select score, dense_rank() over (order by score desc) "Rank" from Scores;

SELECT s.score, Rank FROM
scores s INNER JOIN (
SELECT score, ROWNUM AS Rank FROM
    (
        SELECT score FROM scores
        GROUP BY score
        ORDER BY score DESC
    ) a
) b ON s.score = b.score ORDER BY Rank;
