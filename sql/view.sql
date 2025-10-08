
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