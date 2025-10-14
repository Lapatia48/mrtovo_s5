INSERT INTO departement (libelle_departement) VALUES
('Informatique'),
('Marketing'),
('Ressources Humaines'),
('Gestion de stock'),
('Gestion immobilisation');


-- Diplomes
INSERT INTO diplome (nom_diplome) VALUES
('Baccalaureat'),
('Licence'),
('Master '),
('doctorat');

-- Annonces avec age_min, age_max et id_diplome_requis
INSERT INTO annonce (
    age_min, age_max, id_departement, titre, description, date_publication, nb_personne_utile, salaire, id_diplome_requis
) VALUES
(22, 28, 1, 'Developpeur Java Junior', 'Participation au developpement et a la maintenance d applications Java Spring.', '2025-09-17', 2, 1200000, 3),
(25, 35, 1, 'Administrateur Base de Donnees', 'Gestion et optimisation des bases PostgreSQL de l entreprise.', '2025-09-17', 1, 1500000, 3),
(23, 30, 2, 'Charge de Recrutement', 'Recherche et selection de candidats pour differents postes.', '2025-09-17', 1, 1000000, 2),
(24, 32, 3, 'Comptable', 'Gestion des factures et suivi budgetaire de l entreprise.', '2025-09-17', 1, 1100000, 3),
(21, 29, 4, 'Community Manager', 'Gestion des reseaux sociaux et creation de contenu marketing.', '2025-09-17', 1, 900000, 2),
(26, 36, 4, 'Responsable Marketing Digital', 'Elaboration de strategies publicitaires en ligne.', '2025-09-17', 1, 1400000, 2);

-- Candidats avec id_departement_postule
INSERT INTO candidat (
    nom, prenom, mail, adresse, date_naissance, renseignement, 
    id_diplome, annee_experience, id_departement, id_annonce_postule
) VALUES
('Rasolofoson', 'Lova', 'lova.rasolofoson@gmail.com', 'Ambohidratrimo', '1996-04-15', 'Developpeur backend passionne par les API REST', 1, 3, 1, 2),
('Andriamihaja', 'Feno', 'feno.andriamihaja@gmail.com', 'Ivato', '1997-09-22', 'Specialiste en marketing digital et SEO', 2, 4, 2, 1),
('Ramanandraibe', 'Voahirana', 'voahirana.ramanandraibe@gmail.com', 'Sabotsy Namehana', '1995-12-03', 'Experience en gestion de stock et inventaire', 3, 5, 4, 5),
('Randrianarisoa', 'Tovo', 'tovo.randrianarisoa@gmail.com', 'Alasora', '1994-06-18', 'Gestionnaire RH avec 6 ans dexperience', 4, 6, 3, 3),
('Ratsimbazafy', 'Niry', 'niry.ratsimbazafy@gmail.com', 'Itaosy', '1998-02-27', 'Audit interne et gestion dimmobilisations', 3, 4, 5, 4),
('Rakotondramanana', 'Hanitra', 'hanitra.rakotondramanana@gmail.com', 'Ankadindramamy', '1999-11-10', 'Developpeuse fullstack en montee de competence', 1, 2, 1, 2);

-- Notes QCM
INSERT INTO note_qcm (id_candidat, note) VALUES
(1, 5), -- Informatique -> admis a lentretien
(2, 6), -- Marketing -> admis
(3, 4), -- Stock -> admis
(4, 3), -- RH -> refuse
(5, 5); -- Immobilisation -> admis

-- Entretien pour les candidats admis
INSERT INTO entretien (id_candidat, date_entretien, commentaire, statut, salaire_nifanarahana)
VALUES
(1, '2025-09-17', 'Bon profil technique, motivee', 'valide', 1200000),
(2, '2025-09-17', 'Tres bon sens strategique', 'valide', 1000000),
(3, '2025-09-18', 'Connaissance terrain correcte', 'valide', 950000),
(5, '2025-09-18', 'Bonne maitrise comptable', 'valide', 1100000);

-- Mise en essai
INSERT INTO essai (id_candidat, periode) VALUES
(1, 2), (2, 3), (3, 2), (5, 1);

-- Validation en employe
INSERT INTO employe (id_candidat, poste, salaire) VALUES
(1, 'Developpeuse Fullstack', 1200000),
(2, 'Responsable Marketing Digital', 1000000);

-- Renouvellement dessai
INSERT INTO renouvellement_essai (id_candidat, periode) VALUES
(3, 1);

-- Refus apres essai
INSERT INTO candidat_refuse (id_candidat, libelle_etape) VALUES
(5, 'essai');


insert into dg_admin(nom,mdp) values('Directeur Administrateur', 'mdp123');
insert into rh(nom,mdp) values('ressource humaine', 'mdprh123');
insert into manager(nom,mdp) values('Manager', 'mdp123');
