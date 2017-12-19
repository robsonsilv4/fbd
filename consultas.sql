SELECT e.enome
FROM escola e, nota n
WHERE e.eid = n.eid
GROUP BY e.enome
HAVING AVG (DISTINCT (n.nota)) >= ALL (
       SELECT AVG (DISTINCT (n.nota))
       FROM nota n
       GROUP BY n.eid
);

----------------------------------------
SELECT DISTINCT (j.jnome)
FROM julgador j, nota n, escola e
WHERE e.eid = n.eid AND n.nid = j.jid
AND e.local_concentracao = 'Quixada';
-------------------------------------

SELECT * FROM quesito
WHERE qid IN ((SELECT q.qid
               FROM quesito q)
          EXCEPT (
             (
              SELECT n.qid FROM nota n, julgador j
              WHERE j.jid = n.jid AND j.jnome = 'Joao'
             )
          UNION
             (
              SELECT n.qid FROM nota n, julgador j
              WHERE j.jid = n.jid AND j.jnome = 'Maria')
             ));

--------------------------------------------------------
SELECT q.qdescricao, AVG (n.nota)
FROM quesito q, nota n
WHERE n.qid = q.qid
GROUP BY q.qdescricao
---------------------------------

SELECT * FROM julgador
WHERE jid IN (SELECT n.jid
              WHERE n.eid = e.eid
              AND n.eid = e.eid
              AND e.enome = 'Unidos de Quixada');
-------------------------------------------------

SELECT * FROM julgador j
WHERE NOT EXISTS ((SELECT n.qid
                   FROM nota n, escola e
                   WHERE n.eid = e.eid
                   AND e.enome = 'Unidos de Quixada')
                 EXCEPT
                  (SELECT n.qid
                   FROM nota n, escola e
                   WHERE n.eid = e.eid
                   AND e.enome = 'Unidos de Quixada'
                   AND n.jid = j.jid));
-----------------------------------------------------

SELECT *
FROM quesito q
WHERE NOT EXISTS ((SELECT e.eid
                   FROM escola e)
                 EXCEPT
                  (SELECT n.eid
                   FROM nota n
                   WHERE n.qid = q.qid));
-----------------------------------------

SELECT j.jid, j.jnome
FROM julgador j, quesito q
WHERE NOT EXISTS ((SELECT e.eid
                   FROM nota e)
                 EXCEPT
                  (SELECT n.eid
                   FROM nota n
                   WHERE n.jid = j.jid
                   AND n.qid = q.qid));
---------------------------------------

SELECT *
FROM quesito
WHERE qid NOT IN (SELECT n.qid
                  FROM nota n);
-------------------------------

SELECT DISTINCT (e.enome)
FROM escola e, quesito q, nota n
WHERE e.eid = n.eid
AND n.qid = q.qid
AND q.qdescricao = 'enredo'
AND n.nota > ANY (SELECT n2.nota
                  FROM nota n2, quesito q2
                  WHERE n2.qid = q2.qid
                  AND q2.qdescricao = 'enredo'
                  AND n2.eid != e.eid);
----------------------------------------------


SELECT j.* FROM julgador j
WHERE j.jid IN ((SELECT j2.jid
                 FROM julgador j2)
            EXCEPT
                (SELECT j2.jid
                 FROM julgador j2, nota n, quesito q
                 WHERE j2.jid = n.jid AND q.qid = n.qid
                 AND n.nota > 7 and q.qdescricao != 'enredo'
                ));
------------------------------------------------------------
SELECT j.* FROM julgador j
WHERE j.jid IN ((SELECT j2.jid
                 FROM julgador j2)
            EXCEPT
                (SELECT j2.jid
                 FROM julgador j2
                 JOIN nota n
                 ON j2.jid = n.jid
                 JOIN quesito q
                 ON q.qid = n.qid
                 WHERE n.nota > 7 AND q.qdescricao != 'enredo'
                ));
-------------------------------------------------------------

SELECT e.*
FROM escola e, nota n
WHERE e.eid = n.eid
GROUP BY e.eid
HAVING COUNT (n.nota) < 3;
--------------------------

SELECT DISTINCT q.*
FROM quesito q, nota n, escola e
WHERE q.qid = n.qid AND e.eid = n.eid
AND n.nota > 5 OR e.local_concentracao != 'Quixada';
----------------------------------------------------

SELECT e.enome, n.nota
FROM escola e
LEFT JOIN nota n
ON e.eid = n.eid;
----------------------

SELECT e.enome, n.nota
FROM escola e
LEFT JOIN nota n
ON e.eid = n.eid
WHERE n.eid IS NULL;
----------------------