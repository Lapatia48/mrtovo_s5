
CREATE OR REPLACE VIEW candidat_details_view AS
SELECT 
    c.id,
    c.nom,
    c.prenom,
    c.mail,
    c.adresse,
    c.date_naissance,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.date_naissance)) AS age,
    c.renseignement,
    c.annee_experience,
    c.date_postule,
    d.nom_diplome,
    dep.libelle_departement,
    nq.note AS note_qcm
FROM candidat c
JOIN diplome d ON c.id_diplome = d.id
JOIN departement dep ON c.id_departement = dep.id
LEFT JOIN note_qcm nq ON c.id = nq.id_candidat
ORDER BY c.nom ASC;


CREATE OR REPLACE VIEW questions_reponses_view AS
SELECT
    ROW_NUMBER() OVER () as id,
    q.id AS question_id,
    q.question,
    q.id_departement,
    r.id AS reponse_id,
    r.reponse,
    CASE WHEN vr.id_reponse = r.id THEN true ELSE false END AS est_vraie
FROM questions q
JOIN reponse r ON r.id_question = q.id
LEFT JOIN vrai_reponse vr ON vr.id_question = q.id
ORDER BY q.id, r.id;


CREATE OR REPLACE VIEW candidat_admis_qcm_details AS
SELECT 
    c.id,
    c.nom,
    c.prenom,
    c.mail,
    c.adresse,
    c.date_naissance,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.date_naissance)) AS age,
    c.renseignement,
    c.annee_experience,
    c.date_postule,
    d.nom_diplome,
    dep.libelle_departement,
    a.titre AS annonce_postulee,
    a.salaire AS salaire_annonce,
    nq.note AS note_qcm,
    caq.id AS id_admission_qcm,
    caq.id_candidat
FROM candidat_admis_qcm caq
JOIN candidat c ON caq.id_candidat = c.id
JOIN diplome d ON c.id_diplome = d.id
JOIN departement dep ON c.id_departement = dep.id
JOIN annonce a ON c.id_annonce_postule = a.id
LEFT JOIN note_qcm nq ON c.id = nq.id_candidat
ORDER BY c.nom ASC, c.prenom ASC;


CREATE OR REPLACE VIEW candidat_refuse_details AS
SELECT 
    c.id,
    c.nom,
    c.prenom,
    c.mail,
    c.adresse,
    c.date_naissance,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.date_naissance)) AS age,
    c.renseignement,
    c.annee_experience,
    c.date_postule,
    d.nom_diplome,
    dep.libelle_departement,
    nq.note AS note_qcm,
    cr.libelle_etape,
    cr.id_candidat
FROM candidat c
JOIN diplome d ON c.id_diplome = d.id
JOIN departement dep ON c.id_departement = dep.id
JOIN candidat_refuse cr ON c.id = cr.id_candidat
LEFT JOIN note_qcm nq ON c.id = nq.id_candidat
ORDER BY c.nom ASC, c.prenom ASC;


CREATE OR REPLACE VIEW essai_detail AS
SELECT 
e.id,
e.id_candidat,
e.salaire,
e.periode,
c.nom,
c.prenom,
c.mail,
c.adresse,
c.date_naissance,
EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.date_naissance)) AS age,
c.renseignement,
c.annee_experience,
c.date_postule,
d.nom_diplome,
dep.libelle_departement,
nq.note AS note_qcm,
a.titre AS annonce_postulee
FROM essai e
JOIN candidat c ON e.id_candidat = c.id
JOIN diplome d ON c.id_diplome = d.id
JOIN departement dep ON c.id_departement = dep.id
LEFT JOIN note_qcm nq ON c.id = nq.id_candidat
LEFT JOIN annonce a ON c.id_annonce_postule = a.id
ORDER BY c.nom ASC, c.prenom ASC;


CREATE OR REPLACE VIEW renouvellement_essai_detail AS
SELECT 
    re.id,
    re.id_candidat,
    re.salaire,
    re.periode,
    c.nom,
    c.prenom,
    c.mail,
    c.adresse,
    c.date_naissance,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.date_naissance)) AS age,
    c.renseignement,
    c.annee_experience,
    c.date_postule,
    d.nom_diplome,
    dep.libelle_departement,
    nq.note AS note_qcm,
    a.titre AS annonce_postulee
FROM renouvellement_essai re
JOIN candidat c ON re.id_candidat = c.id
JOIN diplome d ON c.id_diplome = d.id
JOIN departement dep ON c.id_departement = dep.id
LEFT JOIN note_qcm nq ON c.id = nq.id_candidat
LEFT JOIN annonce a ON c.id_annonce_postule = a.id
ORDER BY c.nom ASC, c.prenom ASC;


CREATE OR REPLACE VIEW annonce_detail_candidat AS
SELECT 
    c.id AS candidat_id,
    c.id_annonce_postule,
    a.id AS annonce_id,
    a.titre,
    a.description,
    a.date_publication,
    a.age_min,
    a.age_max,
    a.nb_personne_utile,
    a.salaire,
    d.nom_diplome AS diplome_requis,
    dep.libelle_departement AS departement_annonce
FROM 
    candidat c
    JOIN annonce a ON c.id_annonce_postule = a.id
    LEFT JOIN diplome d ON a.id_diplome_requis = d.id
    LEFT JOIN departement dep ON a.id_departement = dep.id;

CREATE OR REPLACE VIEW conge_etat_details AS
SELECT 
    ce.id,
    ce.id_employe,
    ce.statut,
    ce.date_demande,
    ce.date_validation,
    ce.duree,
    ce.date_debut,
    ce.date_fin,
    e.nom,
    e.prenom,
    e.mail,
    e.departement,
    e.poste,
    e.date_embauche,
    c.quota,
    c.annee
FROM conge_etat ce
JOIN employe e ON ce.id_employe = e.id
LEFT JOIN congee c ON ce.id_employe = c.id_employe AND c.annee = EXTRACT(YEAR FROM CURRENT_DATE)
ORDER BY ce.date_demande DESC;

CREATE OR REPLACE VIEW congee_employe_details AS
SELECT 
    c.id,
    c.id_employe,
    c.quota,
    c.annee,
    e.nom,
    e.prenom,
    e.mail,
    e.departement,
    e.poste,
    e.date_embauche,
    e.statut AS statut_employe,
    COUNT(ce.id) FILTER (WHERE ce.statut = 'approuve' AND EXTRACT(YEAR FROM ce.date_demande) = c.annee) AS conges_pris,
    COALESCE(SUM(ce.duree) FILTER (WHERE ce.statut = 'approuve' AND EXTRACT(YEAR FROM ce.date_demande) = c.annee), 0) AS jours_pris,
    c.quota - COALESCE(SUM(ce.duree) FILTER (WHERE ce.statut = 'approuve' AND EXTRACT(YEAR FROM ce.date_demande) = c.annee), 0) AS solde_restant
FROM congee c
JOIN employe e ON c.id_employe = e.id
LEFT JOIN conge_etat ce ON c.id_employe = ce.id_employe
GROUP BY c.id, c.id_employe, c.quota, c.annee, e.id
ORDER BY e.nom, e.prenom, c.annee DESC;



CREATE OR REPLACE VIEW contrat_employe_view AS
SELECT 
    c.id,
    c.id_employe,
    c.numero_contrat,
    c.type_contrat,
    c.statut_contrat,
    c.date_debut,
    c.date_fin,
    c.poste AS poste_contrat,
    c.classification,
    c.salaire_base,
    c.duree_hebdomadaire,
    c.temps_travail,
    c.periode_essai_jours,
    c.date_fin_essai,
    c.date_creation,
    c.date_modification,
    e.nom,
    e.prenom,
    e.mail,
    e.adresse,
    e.date_naissance,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_naissance)) AS age,
    e.departement,
    e.poste AS poste_employe,
    e.annee_experience,
    e.diplome,
    e.date_embauche,
    e.salaire AS salaire_employe,
    e.statut AS statut_employe
FROM contrat c
JOIN employe e ON c.id_employe = e.id
ORDER BY c.date_creation DESC;


CREATE OR REPLACE VIEW fiche_employe_complete_view AS
SELECT
    -- Données employé (existantes) SANS le mot de passe
    e.id,
    e.id_candidat,
    e.nom,
    e.prenom,
    e.mail,
    e.adresse,
    e.date_naissance,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_naissance)) AS age,
    e.renseignement,
    e.diplome,
    e.annee_experience,
    e.departement,
    e.poste,
    e.date_embauche,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_embauche)) AS anciennete_annees,
    e.salaire,
    e.statut,

    -- Données fiche employé (nouvelles)
    COALESCE(f.photo_url, '/uploads/employes/default_avatar.png') as photo_url,
    f.telephone,
    f.contact_urgence_nom,
    f.contact_urgence_telephone,
    f.numero_securite_sociale,

    -- Données contrat (existantes)
    c.type_contrat,
    c.date_debut,
    c.date_fin,
    c.classification,
    c.salaire_base,
    c.periode_essai_jours,
    c.date_fin_essai

FROM employe e
LEFT JOIN fiche_employe f ON e.id = f.id_employe
LEFT JOIN contrat c ON e.id = c.id_employe AND c.statut_contrat = 'actif';

INSERT INTO fiche_employe (id_employe, photo_url, telephone, contact_urgence_nom, contact_urgence_telephone) 
VALUES (1, '/uploads/employes/images.png', '+261 34 12 345 67', 'Contact Urgence', '+261 33 12 345 67');

UPDATE employe SET 
    nom = 'Rakoto',
    prenom = 'Jean',
    mail = 'jean.rakoto@entreprise.mg',
    adresse = 'Antananarivo',
    date_naissance = '1990-05-15',
    diplome = 'Licence Informatique',
    annee_experience = 5,
    departement = 'Informatique'
WHERE id = 1;