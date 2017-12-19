CREATE TRIGGER remover_quesito
BEFORE DELETE ON quesito FOR EACH ROW
EXECUTE PROCEDURE remover_quesito_q1();

CREATE OR REPLACE FUNCTION remover_quesito_q1()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM nota
    WHERE qid = OLD.qid;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
-----------------------------------------------

CREATE TRIGGER min_musica_nota_up
BEFORE UPDATE ON nota FOR EACH ROW
EXECUTE PROCEDURE min_musica_nota();

CREATE OR REPLACE min_musica_nota()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.qid IN (
    	        SELECT * FROM quesito q
    	        WHERE NEW.qid = q.qid
    	        AND q.qdescricao = 'musica'
    	        AND NEW.nota <= 2))
    THEN
        RETURN NULL;
    ELSE
    	RETURN NEW;
    END IF;
END;
$$ language plpgsql;
-------------------------------------------

CREATE OR REPLACE FUNCTION calc_nota_final (escola INT, quesito INT)
RETURNS VOID AS $$
DECLARE
    julgadores cursor IS (SELECT j.jid
    	                  FROM julgador j)
    	              EXCEPT
    	                 (SELECT j2.jid
    	                  FROM julgador j2, nota n
    	                  WHERE n.qid = quesito
    	                  AND n.eid = escola
    	                  AND n.jid = j2.jid);
    um_julgador INT;
    nota_minina REAL;
BEGIN
    SELECT MIN (n.nota) INTO nota_minina
    FROM nota n
    WHERE n.eid = escola;

    OPEN julgadores;

    FETCH julgadores INTO um_julgador;

    LOOP
       EXIT WHEN NOT FOUND;

       INSE
-----------------------------------------------------


CREATE OR REPLACE FUNCTION min_max()
RETURNS SETOF RECORD AS $$
BEGIN
    EXECUTE QUERY SELECT n.nid, min(n.nota), max(n.nota)
                  FROM nota n
                  GROUP BY n.eid;
    RETURN;
END;
$$ language plpgsql;

SELECT min_max();

CREATE FUNCTION blog_get_pessoas()
RETURNS SETOF RECORD AS $$
BEGIN
    RETURN QUERY SELECT id_pessoa, nome, sobrenome, sexo, cpf
                 FROM pessoa_fisica;
    RETURN;
END;
$$ LANGUAGE plpgsql;