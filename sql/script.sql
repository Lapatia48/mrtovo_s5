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

CREATE TABLE annonce (
    id SERIAL PRIMARY KEY,
    age_min INT,
    age_max INT,
    id_departement INT REFERENCES departement(id),
    titre VARCHAR(150),
    description TEXT,
    date_publication DATE DEFAULT CURRENT_DATE,
    nb_personne_utile INT,
    salaire INT,
    id_diplome_requis INT REFERENCES diplome(id)
);

CREATE TABLE candidat (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    mail VARCHAR(150),
    adresse VARCHAR(200),
    date_naissance DATE,
    renseignement TEXT,
    id_diplome INT REFERENCES diplome(id),
    annee_experience INT,
    id_departement  INT REFERENCES departement(id), 
    date_postule DATE DEFAULT CURRENT_DATE,
    id_annonce_postule INT REFERENCES annonce(id)
);

CREATE TABLE candidat_admis_qcm (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE
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

CREATE TABLE vrai_reponse (
    id SERIAL PRIMARY KEY,
    id_question INT REFERENCES questions(id) ON DELETE CASCADE,
    id_reponse INT REFERENCES reponse(id) ON DELETE CASCADE
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
    salaire INT,
    periode INT
);

CREATE TABLE renouvellement_essai (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    salaire INT,
    periode INT
);

-- =====================
-- Côté employé
CREATE TABLE employe (
    id SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES candidat(id) ON DELETE CASCADE,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    mail VARCHAR(150),
    mot_de_passe VARCHAR(100),
    adresse VARCHAR(200),
    date_naissance DATE,
    renseignement TEXT,
    diplome VARCHAR(100),
    annee_experience INT,
    departement VARCHAR(100), 
    poste VARCHAR(100),
    date_embauche DATE DEFAULT CURRENT_DATE,
    salaire INT,
    statut VARCHAR(50) DEFAULT 'actif'
);

CREATE TABLE dg_admin (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    mdp VARCHAR(100)
);

-- =====================congee================
CREATE TABLE congee (
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES employe(id) ON DELETE CASCADE,
    quota INT DEFAULT 30,
    quota_exceptionnel INT DEFAULT 5,
    annee INT DEFAULT EXTRACT(YEAR FROM CURRENT_DATE)
);

CREATE TABLE conge_etat (
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES employe(id) ON DELETE CASCADE,
    statut VARCHAR(50) DEFAULT 'en_attente',
    date_demande DATE DEFAULT CURRENT_DATE,
    date_validation DATE,
    duree INT,
    date_debut DATE,
    date_fin DATE
);

CREATE TABLE paie (
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES employe(id) ON DELETE CASCADE,
    date_paie DATE DEFAULT CURRENT_DATE,
    periode_debut DATE,
    periode_fin DATE,
    
    salaire_base DECIMAL(15,2),
    heures_sup_normales DECIMAL(15,2) DEFAULT 0,
    heures_sup_weekend DECIMAL(15,2) DEFAULT 0,
    prime_anciennete DECIMAL(15,2) DEFAULT 0,
    absences DECIMAL(15,2) DEFAULT 0,
    autres_primes DECIMAL(15,2) DEFAULT 0,
    
    salaire_brut DECIMAL(15,2),
    retenue_cnaps DECIMAL(15,2) DEFAULT 0,
    retenue_ostie DECIMAL(15,2) DEFAULT 0,
    retenue_irsa DECIMAL(15,2) DEFAULT 0,
    total_retenues DECIMAL(15,2),
    net_a_payer DECIMAL(15,2),
    
    mode_paiement VARCHAR(50) DEFAULT 'Virement'
);


CREATE TABLE contrat (
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES employe(id) ON DELETE CASCADE,
    numero_contrat VARCHAR(50) UNIQUE NOT NULL,
    type_contrat VARCHAR(20) NOT NULL,           -- CDI, CDD, INTERIM, APPRENTISSAGE
    statut_contrat VARCHAR(20) DEFAULT 'actif',  -- actif, termine, rompu
    date_debut DATE NOT NULL,
    date_fin DATE,                               -- NULL pour CDI
    poste VARCHAR(100) NOT NULL,
    classification VARCHAR(20),                  -- Cadre, ETAM, Ouvrier
    salaire_base DECIMAL(10,2) NOT NULL,
    duree_hebdomadaire INT DEFAULT 35,           -- Heures par semaine
    temps_travail VARCHAR(10) DEFAULT 'Plein',   -- Plein, Partiel
    periode_essai_jours INT DEFAULT 0,           -- 0 si aucune
    date_fin_essai DATE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE fiche_employe (
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES employe(id) ON DELETE CASCADE,
    photo_url VARCHAR(255),
    telephone VARCHAR(20),
    contact_urgence_nom VARCHAR(100),
    contact_urgence_telephone VARCHAR(20),
    numero_securite_sociale VARCHAR(50),
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- merge erica

ALTER TABLE congee 
ADD COLUMN quota_exceptionnel INT DEFAULT 5;

CREATE TABLE pointage_employe (
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES employe(id) ON DELETE CASCADE,
    date_evenement DATE DEFAULT CURRENT_DATE,
    type_evenement VARCHAR(50) NOT NULL,           -- 'absence', 'retard', 'maladie', 'mission'
    sous_type VARCHAR(50),                         -- 'justifiee', 'non_justifiee'
    duree_jours DECIMAL(4,2) DEFAULT 0,           -- 1.0, 0.5, etc.
    heures_retard INT DEFAULT 0,                   -- minutes de retard
    equivalent_jours DECIMAL(4,2) DEFAULT 0,       -- 0.125 pour 1h
    impact_annuel DECIMAL(4,2) DEFAULT 0,          -- impact quota annuel
    impact_exceptionnel DECIMAL(4,2) DEFAULT 0,    -- impact quota exceptionnel
    motif TEXT,                                    -- raison
    statut VARCHAR(50) DEFAULT 'valide',           -- 'valide', 'annule'
    date_saisie TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

