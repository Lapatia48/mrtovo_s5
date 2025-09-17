INSERT INTO departement (libelle_departement) VALUES
('Informatique'),
('Marketing'),
('Ressources Humaines'),
('Gestion de stock'),
('Gestion immobilisation');

-- Questions Informatique
INSERT INTO questions (question, id_departement) VALUES
('Quel langage est principalement utilise avec CodeIgniter ?', 1),
('Quelle base de donnees est recommande avec PostgreSQL ?', 1),
('Quel outil permet de creer des wireframes ?', 1),
('Quel framework Java utilise le fichier dispatcher-servlet.xml ?', 1),
('Quel est le role de Maven dans un projet Java ?', 1),
('Quel format est utilise pour les icones vectorielles ?', 1);

-- Reponses (1 bonne par question)
INSERT INTO reponse (id_question, reponse) VALUES
(1, 'PHP'), (1, 'JavaScript'), (1, 'Python'),
(2, 'PostgreSQL'), (2, 'MongoDB'), (2, 'SQLite'),
(3, 'Figma'), (3, 'Photoshop'), (3, 'Excel'),
(4, 'Spring MVC'), (4, 'Hibernate'), (4, 'Laravel'),
(5, 'Gestion des dependances'), (5, 'Creation de PDF'), (5, 'Design UI'),
(6, 'SVG'), (6, 'JPG'), (6, 'DOCX');

-- Questions Marketing
INSERT INTO questions (question, id_departement) VALUES
('Quel outil est utilise pour analyser le trafic web ?', 2),
('Quel est le role dun persona ?', 2),
('Que signifie le terme SEO ?', 2),
('Quel canal est le plus utilise pour le marketing digital ?', 2),
('Quel est un bon taux de conversion moyen ?', 2),
('Quel outil permet de planifier des publications sur les reseaux ?', 2);

-- Reponses
INSERT INTO reponse (id_question, reponse) VALUES
(7, 'Google Analytics'), (7, 'Figma'), (7, 'Slack'),
(8, 'Profil type de client'), (8, 'Nom de marque'), (8, 'Logo'),
(9, 'Optimisation pour les moteurs de recherche'), (9, 'Service externe offert'), (9, 'Systeme economique ouvert'),
(10, 'Email'), (10, 'Television'), (10, 'Radio'),
(11, '2-5%'), (11, '20-30%'), (11, '50-60%'),
(12, 'Buffer'), (12, 'Excel'), (12, 'PowerPoint');

-- Questions Ressources Humaines
INSERT INTO questions (question, id_departement) VALUES
('Quel document est genere lors dune embauche ?', 3),
('Quel outil est utilise pour gerer les candidatures ?', 3),
('Que signifie CDD ?', 3),
('Quel est le role dun entretien RH ?', 3),
('Quel indicateur mesure la satisfaction des employes ?', 3),
('Quel est le delai legal dun contrat dessai ?', 3);

-- Reponses
INSERT INTO reponse (id_question, reponse) VALUES
(13, 'Contrat de travail'), (13, 'Facture'), (13, 'Devis'),
(14, 'ATS'), (14, 'CMS'), (14, 'ERP'),
(15, 'Contrat a duree determinee'), (15, 'Contrat de developpement'), (15, 'Contrat de demande'),
(16, 'Evaluer le profil'), (16, 'Signer le contrat'), (16, 'Attribuer le salaire'),
(17, 'eNPS'), (17, 'KPI'), (17, 'ROI'),
(18, '2 mois'), (18, '6 mois'), (18, '1 an');

-- Questions Gestion de stock
INSERT INTO questions (question, id_departement) VALUES
('Quel indicateur permet de mesurer la rotation des stocks ?', 4),
('Quel document accompagne la reception de marchandises ?', 4),
('Quel est le role dun inventaire physique ?', 4),
('Quel outil permet de suivre les entrees et sorties de produits ?', 4),
('Quel est le risque principal dun surstock ?', 4),
('Quel systeme est utilise pour gerer les niveaux de stock automatiquement ?', 4);

-- Reponses
INSERT INTO reponse (id_question, reponse) VALUES
(19, 'Taux de rotation'), (19, 'Marge brute'), (19, 'ROI'),
(20, 'Bon de livraison'), (20, 'Facture'), (20, 'Devis'),
(21, 'Verifier les quantites reelles'), (21, 'Calculer les prix de vente'), (21, 'Creer des fiches produit'),
(22, 'Logiciel de gestion de stock'), (22, 'CRM'), (22, 'ERP RH'),
(23, 'Immobilisation inutile'), (23, 'Rupture de stock'), (23, 'Amelioration du cash-flow'),
(24, 'Reapprovisionnement automatique'), (24, 'Gestion manuelle'), (24, 'Audit comptable');

-- Questions Gestion dimmobilisation
INSERT INTO questions (question, id_departement) VALUES
('Quel document formalise lacquisition dun bien immobilise ?', 5),
('Quel type dimmobilisation concerne un ordinateur ?', 5),
('Quel est le role de lamortissement ?', 5),
('Quel logiciel est souvent utilise pour gerer les immobilisations ?', 5),
('Quel compte comptable est associe aux immobilisations corporelles ?', 5),
('Quel indicateur mesure la duree de vie dun actif ?', 5);

-- Reponses
INSERT INTO reponse (id_question, reponse) VALUES
(25, 'Bon de commande'), (25, 'Contrat de travail'), (25, 'Facture client'),
(26, 'Immobilisation corporelle'), (26, 'Immobilisation incorporelle'), (26, 'Stock'),
(27, 'Repartir le cout sur plusieurs annees'), (27, 'Augmenter la valeur comptable'), (27, 'Reduire les charges sociales'),
(28, 'SAGE Immobilisations'), (28, 'Photoshop'), (28, 'Trello'),
(29, '218'), (29, '401'), (29, '512'),
(30, 'Duree damortissement'), (30, 'Taux de rentabilite'), (30, 'Volume de production');

-- Diplomes
INSERT INTO diplome (nom_diplome) VALUES
('Licence Informatique'),
('Master Marketing'),
('Licence Gestion'),
('Master RH');

-- Candidats
INSERT INTO candidat (nom, prenom, mail, adresse, date_naissance, renseignement, id_diplome, annee_experience, id_departement)
VALUES
('Rasolofoson', 'Lova', 'lova.rasolofoson@gmail.com', 'Ambohidratrimo', '1996-04-15', 'Developpeur backend passionne par les API REST', 1, 3, 1),
('Andriamihaja', 'Feno', 'feno.andriamihaja@gmail.com', 'Ivato', '1997-09-22', 'Specialiste en marketing digital et SEO', 2, 4, 2),
('Ramanandraibe', 'Voahirana', 'voahirana.ramanandraibe@gmail.com', 'Sabotsy Namehana', '1995-12-03', 'Experience en gestion de stock et inventaire', 3, 5, 4),
('Randrianarisoa', 'Tovo', 'tovo.randrianarisoa@gmail.com', 'Alasora', '1994-06-18', 'Gestionnaire RH avec 6 ans dexperience', 4, 6, 3),
('Ratsimbazafy', 'Niry', 'niry.ratsimbazafy@gmail.com', 'Itaosy', '1998-02-27', 'Audit interne et gestion dimmobilisations', 3, 4, 5),
('Rakotondramanana', 'Hanitra', 'hanitra.rakotondramanana@gmail.com', 'Ankadindramamy', '1999-11-10', 'Developpeuse fullstack en montee de competence', 1, 2, 1);

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
