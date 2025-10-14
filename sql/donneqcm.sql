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

-- Vraies réponses Informatique
INSERT INTO vrai_reponse (id_question, id_reponse) VALUES
(1, 1),  -- PHP
(2, 4),  -- PostgreSQL
(3, 7),  -- Figma
(4, 10), -- Spring MVC
(5, 13), -- Gestion des dependances
(6, 16); -- SVG

-- Vraies réponses Marketing
INSERT INTO vrai_reponse (id_question, id_reponse) VALUES
(7, 19),  -- Google Analytics
(8, 22),  -- Profil type de client
(9, 25),  -- Optimisation pour les moteurs de recherche
(10, 28), -- Email
(11, 31), -- 2-5%
(12, 34); -- Buffer

-- Vraies réponses Ressources Humaines
INSERT INTO vrai_reponse (id_question, id_reponse) VALUES
(13, 37), -- Contrat de travail
(14, 40), -- ATS
(15, 43), -- Contrat a duree determinee
(16, 46), -- Evaluer le profil
(17, 49), -- eNPS
(18, 52); -- 2 mois

-- Vraies réponses Gestion de stock
INSERT INTO vrai_reponse (id_question, id_reponse) VALUES
(19, 55), -- Taux de rotation
(20, 58), -- Bon de livraison
(21, 61), -- Verifier les quantites reelles
(22, 64), -- Logiciel de gestion de stock
(23, 66), -- Rupture de stock
(24, 70); -- Reapprovisionnement automatique

-- Vraies réponses Gestion immobilisation
INSERT INTO vrai_reponse (id_question, id_reponse) VALUES
(25, 73), -- Bon de commande
(26, 76), -- Immobilisation corporelle
(27, 79), -- Repartir le cout sur plusieurs annees
(28, 82), -- SAGE Immobilisations
(29, 85), -- 218
(30, 88); -- Duree damortissement
