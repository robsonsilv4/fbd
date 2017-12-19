CREATE TABLE quesito (
    qid INTEGER,
    qdescricao VARCHAR(20),
    PRIMARY KEY (qid)
);

CREATE TABLE julgador (
    jid INTEGER,
    jnome VARCHAR(20),
    sexo CHAR,
    PRIMARY KEY (jid)
);

CREATE TABLE escola (
    eid INTEGER,
    enome VARCHAR(20),
    local_concentracao VARCHAR(20),
    PRIMARY KEY (eid)
);

CREATE TABLE nota (
    qid INTEGER,
    jid INTEGER,
    eid INTEGER,
    nota REAL,
    PRIMARY KEY (qid, jid, eid),
    CONSTRAINT nota_fk1 FOREIGN KEY (qid) REFERENCES quesito (qid),
    CONSTRAINT nota_fk2 FOREIGN KEY (jid) REFERENCES julgador (jid)
    CONSTRAINT nota_fk3 FOREIGN KEY (eid) REFERENCES escola(eid)
);