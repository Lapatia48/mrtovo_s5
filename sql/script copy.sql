-- Création de la base
CREATE DATABASE tovo_s5;
\c tovo_s5;

-- =====================
-- Côté candidat
-- =====================

CREATE TABLE diplome (
    id SERIAL PRIMARY KEY,
    nom_diplome VARCHAR(100)
);

CREATE TABLE departement (
    id SERIAL PRIMARY KEY,
    libelle_departement VARCHAR(100)
);

CREATE TABLE candidat (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    mail VARCHAR(150) UNIQUE,
    adresse VARCHAR(200),
    date_naissance DATE,
    renseignement TEXT,
    id_diplome INT REFERENCES diplome(id),
    annee_experience INT,
    id_departement  INT REFERENCES departement(id), 
    date_postule DATE DEFAULT CURRENT_DATE
);

CREATE TABLE candidat_refuse (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    libelle_etape VARCHAR(100)
);

-- =====================
-- Côté manager
-- =====================

CREATE TABLE manager (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    mdp VARCHAR(100)
);



CREATE TABLE annonce (
    id SERIAL PRIMARY KEY,
    id_departement INT REFERENCES departement(id),
    titre VARCHAR(150),
    description TEXT,
    date_publication DATE DEFAULT CURRENT_DATE,
    nb_personne_utile INT,

    salaire INT
);

CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    question VARCHAR(255),
    id_departement INT REFERENCES departement(id)
);

CREATE TABLE reponse (
    id SERIAL PRIMARY KEY,
    id_question INT REFERENCES questions(id) ON DELETE CASCADE,
    reponse VARCHAR(255)
);

CREATE TABLE note_qcm (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    note INT
);



-- =====================
-- Côté RH
-- =====================

CREATE TABLE rh (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    mdp VARCHAR(100)
);

CREATE TABLE entretien (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    date_entretien DATE,
    commentaire TEXT,
    statut VARCHAR(50),
    salaire_nifanarahana INT
);

CREATE TABLE essai (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    periode INT
);

CREATE TABLE renouvellement_essai (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    periode INT
);

CREATE TABLE employe (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    date_embauche DATE DEFAULT CURRENT_DATE,
    poste VARCHAR(100),
    salaire INT
);

CREATE TABLE dg_admin (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    mdp VARCHAR(100)
);
