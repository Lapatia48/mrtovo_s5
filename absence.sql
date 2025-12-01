INSERT INTO pointage_employe (id_employe, date_evenement, type_evenement, sous_type, duree_jours, motif, statut) VALUES
(6, CURRENT_DATE - INTERVAL '5 days', 'absence', 'justifiee', 1.0, 'Maladie', 'valide'),
(7, CURRENT_DATE - INTERVAL '10 days', 'maladie', 'justifiee', 2.0, 'Grippe', 'valide'),
(8, CURRENT_DATE - INTERVAL '3 days', 'absence', 'non_justifiee', 0.5, 'Retard non justifié', 'valide'),
(9, CURRENT_DATE - INTERVAL '15 days', 'maladie', 'justifiee', 3.0, 'Angine', 'valide'),
(10, CURRENT_DATE - INTERVAL '8 days', 'absence', 'justifiee', 1.0, 'Rendez-vous médical', 'valide'),
(11, CURRENT_DATE - INTERVAL '20 days', 'absence', 'non_justifiee', 1.0, 'Absence non justifiée', 'valide');